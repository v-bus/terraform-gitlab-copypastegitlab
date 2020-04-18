terraform {
  required_version = ">= 0.12"
  required_providers {
    gitlab = "~> 2.6"
  }
}

provider "gitlab" {
  token    = var.token
  base_url = var.url
}

# resource "gitlab_project" "dst_projects" {
#   depends_on = [gitlab_group.dst_groups]
#   count   = length(var.projects)
#   name        = "example"
#   description = "My awesome codebase"

#   visibility_level = "private"
#   path = "example"
#   container_registry_enabled = false
#   lfs_enabled = true
#   pipelines_enabled = false
#   snippets_enabled = false
#   wiki_enabled = false
#   namespace_id = gitlab_group.first.id
# }

