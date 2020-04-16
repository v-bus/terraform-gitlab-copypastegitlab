output "groups" {
  value = { for group in jsondecode(data.http.get_groups.body) :
    group.id => group.full_path
  }
  description = "returns map of goups { 'id' = 'full_path' }"
}
output "projects" {
  value       = local.projects
  description = "returns list of maps of progects { 'full_path' = 'group/subroup' 'path' = 'project' 'project_ssh' = 'git@gitlab.myserver.com:group/subroup/project.git'}"
}
output "zgit_clone" {
  value       = [for res in data.external.git_clone : res.result]
  description = "returns git_clone.sh result { 'git@myserver.com:user/project.git' = 'True' }"
}