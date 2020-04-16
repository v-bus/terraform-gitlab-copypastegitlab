output "groups" {
  value = { for group in jsondecode(data.http.get_groups.body) :
    group.id => group.full_path
  }
}
output "projects" {
  value = [
    for project in jsondecode(data.http.get_groups_projects[0].body) : [project.path, project.path_with_namespace, project.ssh_url_to_repo]
  ]
}