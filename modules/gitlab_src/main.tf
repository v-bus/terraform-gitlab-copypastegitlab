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
  url   = "${var.url}${var.api}groups?per_page=100"
  request_headers = {
    Private-Token = "${var.token}"
  }
}

#####################################################
# Get list of list of group PROJECTS (local.groups)
#####################################################
data "http" "get_projects" {
  count = ceil(var.project_total_number/100)
  url   = "${var.url}${var.api}projects?page=${count.index}&per_page=100"

  request_headers = {
    Private-Token = "${var.token}"
  }
}
locals {
  # list of projects and project_paths
  _project_paths = [for page in data.http.get_projects : [for project in jsondecode(page.body) : project.namespace["full_path"]]]
  _projects      = [for page in data.http.get_projects : [for project in jsondecode(page.body) : project.ssh_url_to_repo]]

  # list of selected projects
  projects = flatten([for index in range(0, length(local._projects)) : matchkeys(local._projects[index], local._project_paths[index], var.groups)])

  # list of selected projects paths
  project_paths = flatten([for page in data.http.get_projects : [for project in jsondecode(page.body) : project.namespace["full_path"] if contains(local.projects, project.ssh_url_to_repo)]])

  # project_names = [ for project in jsondecode(data.http.get_projects.body) : project.path if contains(local.projects, project.ssh_url_to_repo)]
}
data "external" "git_clone" {
  depends_on = [data.http.get_projects]
  count      = length(local.projects)
  program    = ["python", "${path.cwd}/exec/git_clone.py"]
  query = {
    workdir     = var.workdir
    clonedir    = "${local.project_paths[count.index]}/${replace(local.projects[count.index], "/.*/([a-zA-Z0-9-_]*).git/", "$1")}"
    project_ssh = local.projects[count.index]
    logfile     = var.log_filepath
  }
}
