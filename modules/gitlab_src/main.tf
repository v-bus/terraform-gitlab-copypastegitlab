terraform {
  required_version = ">= 0.12"
  required_providers {
    gitlab   = "~> 2.6"
    external = "~> 1.2"
    http     = "~> 1.2"
  }
}

provider "gitlab" {
  token    = var.token
  base_url = "${var.url}${var.api}"
}
#####################################################
# Get ALL accessable groups with attributes (eg. id)
#####################################################
data "http" "get_groups" {
  count = var.get_groups ? 1 : 0
  url   = "${var.url}${var.api}groups?pagination=keyset&per_page=${var.perpage}&order_by=id"
  request_headers = {
    Authorization = "Bearer ${var.token}"
  }
}

#####################################################
# Get list of list of group PROJECTS (local.groups)
#####################################################
data "http" "get_projects" {
  url = "${var.url}${var.api}projects?pagination=keyset&per_page=${var.perpage}&order_by=id&simple=true"

  request_headers = {
    Authorization = "Bearer ${var.token}"
  }
}
locals {
  # list of projects and project_paths
  _project_paths = [for project in jsondecode(data.http.get_projects.body) : project.namespace["full_path"]]
  _projects      = [for project in jsondecode(data.http.get_projects.body) : project.ssh_url_to_repo]

  # list of selected projects
  projects = matchkeys(local._projects, local._project_paths, var.groups)

  # list of selected projects paths
  project_paths = [for project in jsondecode(data.http.get_projects.body) : project.namespace["full_path"] if contains(local.projects, project.ssh_url_to_repo)]

  # project_names = [ for project in jsondecode(data.http.get_projects.body) : project.path if contains(local.projects, project.ssh_url_to_repo)]
}
data "external" "git_clone" {
  depends_on = [data.http.get_projects]
  count      = length(local.projects)
  program    = ["python", "${path.cwd}/exec/git_clone.py"]
  query = {
    workdir     = var.workdir
    clonedir    = local.project_paths[count.index]
    project_ssh = local.projects[count.index]
    logfile     = var.log_filepath
  }
}
