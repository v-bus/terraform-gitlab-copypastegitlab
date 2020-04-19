# #####################################################
# # Get ALL Projects
# #####################################################
# data "http" "get_projects" {
#   url = "${var.url}${var.api}projects?pagination=keyset&per_page=${var.perpage}&order_by=id&simple=true"

#   request_headers = {
#     Authorization = "Bearer ${var.token}"
#   }
# }
# locals {
#   ###########################################
#   # remove already exists projects
#   ###########################################

#   # list of all ssh_urls and gruop path of each project on gitlab site
#   _site_projects = [for project in jsondecode(data.http.get_projects.body) : project.path_with_namespace]
#   # copy only nonexisting projects on gitlab site
#   _upload_projects = [for project in var.upload_projects : {keys(project)[0] = values(project)[0]} 
#      if contains(local._site_projects,"${values(project)[0]}/${replace(keys(project)[0], "/.*/([a-zA-Z0-9-_]*).git/", "$1")}") == false ]

# }
# resource "gitlab_project" "dst_projects" {
#   depends_on = [local.all_groups_with_id]
#   count      = length(local._upload_projects)

#   name = replace(keys(local._upload_projects[count.index])[0], "/.*/([a-zA-Z0-9-_]*).git/", "$1")

#   visibility_level           = "private"
#   path                       = replace(keys(local._upload_projects[count.index])[0], "/.*/([a-zA-Z0-9-_]*).git/", "$1")
#   container_registry_enabled = false
#   lfs_enabled                = true
#   pipelines_enabled          = false
#   snippets_enabled           = false
#   wiki_enabled               = false
#   namespace_id               = [for id, full_path in local.all_groups_with_id : id if full_path == values(local._upload_projects[count.index])[0]][0]
# }