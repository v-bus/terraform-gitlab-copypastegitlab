output zero_groups {
  value = gitlab_group.zero_groups
}
output first_level_groups {
  value = gitlab_group.first_level_groups
}
output second_level_groups {
  value = gitlab_group.second_level_groups
}
output third_level_groups {
  value = gitlab_group.third_level_groups
}
output forth_level_groups {
  value = gitlab_group.forth_level_groups
}

output zgroup {
  value = local._groups
}
output zprojects {
  value = distinct([for project in var.upload_projects : values(project)[0]])
}
output zgroups_with_ids {
  value = local.all_groups_with_id
}