
resource "gitlab_project" "dst_projects" {
  depends_on = [local.all_groups_with_id]
  count      = length(var.upload_projects)
  # TODO remove regex workaround
  name = regex("(\\w*).",
    regex("([^/]+)/?$",
      keys(var.upload_projects[count.index])[0]
    )[0]
  )[0]

  visibility_level = "private"
  path = regex("(\\w*).",
    regex("([^/]+)/?$",
      keys(var.upload_projects[count.index])[0]
    )[0]
  )[0]
  container_registry_enabled = false
  lfs_enabled                = true
  pipelines_enabled          = false
  snippets_enabled           = false
  wiki_enabled               = false
  namespace_id               = [for id, full_path in local.all_groups_with_id : id if full_path == values(var.upload_projects[count.index])[0]][0]
}