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
  url = "${var.url}${var.api}groups?per_page=100"
  request_headers = {
    Authorization = "Bearer ${var.token}"
  }
}
locals {
  # list of groups and subgoups
  groups = jsondecode(data.http.get_groups.body)
}

#####################################################
# Get list of list of group PROJECTS (local.groups)
#####################################################
data "http" "get_groups_projects" {
  depends_on = [data.http.get_groups]
  count      = length(local.groups)
  url        = "${var.url}${var.api}groups/${local.groups[count.index].id}/projects?per_page=100"
  request_headers = {
    Authorization = "Bearer ${var.token}"
  }
}
locals {
  # list of projects
  projects = flatten([for projects in data.http.get_groups_projects : [
    for project in jsondecode(projects.body) : zipmap(["full_path", "path", "project_ssh"], [project.namespace["full_path"], project.path, project.ssh_url_to_repo])
    ]
  ])
}
data "external" "git_clone" {
  depends_on = [data.http.get_groups, data.http.get_groups_projects]
  # local.projects[i].full_path - (group/subgroup/../project)
  # local.projects[i].path -  (project name)
  # local.projects[i].project_ssh - ssh clone address (eg. git@gitlab.myserver.com:group/subgroup/project.git)
  count   = length(local.projects)
  program = ["bash", "git_clone.sh"]
  query = {
    workdir     = "/tmp"
    clonedir    = local.projects[count.index].full_path
    project_ssh = local.projects[count.index].project_ssh
    logfile     = "${path.cwd}/git_clone.log"
  }
}