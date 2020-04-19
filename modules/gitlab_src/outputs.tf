output "groups" {
  value = var.get_groups ? [for group in try(jsondecode(data.http.get_groups[0].body), { "full_path" = "no groups" }) :
    group.full_path
  ] : ["no groups"]
  description = "returns map of goups { 'id' = 'full_path' }"
}
output "projects" {
  value       = [for index in range(0, length(local.projects)) : { "${local.projects[index]}" = "${local.project_paths[index]}" }]
  description = "returns list of maps of projects { 'full_path' = 'group/subroup' 'path' = 'project' 'project_ssh' = 'git@gitlab.myserver.com:group/subroup/project.git'}"
}
output "zgit_clone" {
  value       = [for res in data.external.git_clone : res.result]
  description = "returns git_clone.sh result { 'git@myserver.com:user/project.git' = 'True' }"
}