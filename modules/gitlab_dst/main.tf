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
  base_url = var.url
}


data "external" "git_push" {
  depends_on = [gitlab_project.dst_projects]
  count      = length(gitlab_project.dst_projects)
  program    = ["python", "${path.cwd}/exec/git_push.py"]
  query = {
    workdir     = var.workdir
    repodir    = replace(gitlab_project.dst_projects[count.index].ssh_url_to_repo, "/[^:]*:(.*).git/", "$1")
    project_ssh = gitlab_project.dst_projects[count.index].ssh_url_to_repo
    logfile     = var.log_filepath
  }
}