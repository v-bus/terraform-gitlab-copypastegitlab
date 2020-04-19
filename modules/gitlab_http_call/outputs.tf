output groups {
  description = "list of maps of GitLab groups"
  value       = jsondecode(data.http.get_groups.body)
}

output projects {
  description = "list of maps of GitLab projects"
  value       = jsondecode(data.http.get_projects.body)
}