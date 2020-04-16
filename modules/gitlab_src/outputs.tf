output "groups" {
  value = { for group in jsondecode(data.http.get_groups.body) :
    group.id => group.full_path
  }
}
output "projects" {
  value = local.projects
}
output "debug" {
  value = jsondecode(data.http.get_groups_projects[0].body)
}
output "zgit_clone" {
  value       = [ for res in data.external.git_clone: 
      res
  ]
  description = "returns git_clone.sh result"
}