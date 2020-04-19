locals {

}

#################################################################
# Get groups to check if groups from list exists on a server
#################################################################
data "http" "get_groups" {
  url = "${var.url}${var.api}groups?pagination=keyset&per_page=${var.perpage}&order_by=id"
  request_headers = {
    Authorization = "Bearer ${var.token}"
  }
}

locals {
  # remove empty elements from input variables
  __groups = distinct(compact(concat(var.groups, [for project in var.upload_projects : values(project)[0]])))
  # list of all fullpaths on gitlab site
  __site_groups = [for group in jsondecode(data.http.get_groups.body) : group.full_path]
  # list of nonexisting groups should be created
  _groups = [for pv_group in local.__groups : pv_group if contains(local.__site_groups, pv_group) != true]
  # gitlab.com/zero_groups
  _zero_groups = distinct([for group in local._groups : split("/", group)[0]])
  # zero_groups object has parent_path attribute zero here magical 1sk2TCAb
  zero_groups = { "1sk2TCAb" = local._zero_groups }
  ## gitlab.com/zero_groups/first_level_groups
  _first_level_groups = distinct([for group in local._groups : split("/", group)[1] if length(split("/", group)) == 2])
  first_level_groups  = [for first in local._first_level_groups : { for zero in local._zero_groups : zero => first if contains(local._groups, "${zero}/${first}") }]
  ### gitlab.com/zero_groups/first_level_groups/second_level_groups
  _second_level_groups = distinct([for group in local._groups : split("/", group)[2] if length(split("/", group)) == 3])
  ####                             count second group layer                count 1st grp layer            put "group/subgroup" as a key                if we can                         find "group/subgroup/subgroup" in a list
  second_level_groups = [for second in local._second_level_groups : { for first in local.first_level_groups : "${keys(first)[0]}/${values(first)[0]}" => second if contains(local._groups, "${keys(first)[0]}/${values(first)[0]}/${second}") }]
  #### gitlab.com/zero_groups/first_level_groups/second_level_groups/third_level_groups
  _third_level_groups = distinct([for group in local._groups : split("/", group)[3] if length(split("/", group)) == 4])
  third_level_groups  = [for third in local._third_level_groups : { for second in local.second_level_groups : "${keys(second)[0]}/${values(second)[0]}" => third if contains(local._groups, "${keys(second)[0]}/${values(second)[0]}/${third}") }]
  ##### gitlab.com/zero_groups/first_level_groups/second_level_groups/third_level_groups/forth_level_groups
  _forth_level_groups = distinct([for group in local._groups : split("/", group)[4] if length(split("/", group)) == 5])
  forth_level_groups  = [for forth in local._forth_level_groups : { for third in local.third_level_groups : "${keys(third)[0]}/${values(third)[0]}" => forth if contains(local._groups, "${keys(third)[0]}/${values(third)[0]}/${forth}") }]
}

resource "gitlab_group" "zero_groups" {
  count     = length(local.zero_groups["1sk2TCAb"])
  name      = local.zero_groups["1sk2TCAb"][count.index]
  path      = local.zero_groups["1sk2TCAb"][count.index]
  parent_id = 0
}

resource "gitlab_group" "first_level_groups" {
  depends_on = [gitlab_group.zero_groups]
  count      = length(local.first_level_groups)
  name       = values(local.first_level_groups[count.index])[0]
  path       = values(local.first_level_groups[count.index])[0]
  parent_id  = [for zero in gitlab_group.zero_groups : zero.id if zero.full_path == keys(local.first_level_groups[count.index])[0]][0]
}

resource "gitlab_group" "second_level_groups" {
  depends_on = [gitlab_group.first_level_groups]
  count      = length(local.second_level_groups)
  name       = values(local.second_level_groups[count.index])[0]
  path       = values(local.second_level_groups[count.index])[0]
  parent_id  = [for first in gitlab_group.first_level_groups : first.id if first.full_path == keys(local.second_level_groups[count.index])[0]][0]
}
resource "gitlab_group" "third_level_groups" {
  depends_on = [gitlab_group.second_level_groups]
  count      = length(local.third_level_groups)
  name       = values(local.third_level_groups[count.index])[0]
  path       = values(local.third_level_groups[count.index])[0]
  parent_id  = [for second in gitlab_group.second_level_groups : second.id if second.full_path == keys(local.third_level_groups[count.index])[0]][0]
}
resource "gitlab_group" "forth_level_groups" {
  depends_on = [gitlab_group.third_level_groups]
  count      = length(local.forth_level_groups)
  name       = values(local.forth_level_groups[count.index])[0]
  path       = values(local.forth_level_groups[count.index])[0]
  parent_id  = [for third in gitlab_group.third_level_groups : third.id if third.full_path == keys(local.forth_level_groups[count.index])[0]][0]
}




locals {
  zero_group_ids          = { for index in range(0, length(gitlab_group.zero_groups)) : gitlab_group.zero_groups[index].id => gitlab_group.zero_groups[index].full_path }
  first_level_groups_ids  = { for index in range(0, length(gitlab_group.first_level_groups)) : gitlab_group.first_level_groups[index].id => gitlab_group.first_level_groups[index].full_path }
  second_level_groups_ids = { for index in range(0, length(gitlab_group.second_level_groups)) : gitlab_group.second_level_groups[index].id => gitlab_group.second_level_groups[index].full_path }
  third_level_groups_ids  = { for index in range(0, length(gitlab_group.third_level_groups)) : gitlab_group.third_level_groups[index].id => gitlab_group.third_level_groups[index].full_path }
  forth_level_groups_ids  = { for index in range(0, length(gitlab_group.forth_level_groups)) : gitlab_group.forth_level_groups[index].id => gitlab_group.forth_level_groups[index].full_path }


  # collect group ids
  created_groups_with_ids = zipmap(
    concat(keys(local.zero_group_ids), keys(local.first_level_groups_ids), keys(local.second_level_groups_ids), keys(local.third_level_groups_ids), keys(local.forth_level_groups_ids)),
    concat(values(local.zero_group_ids), values(local.first_level_groups_ids), values(local.second_level_groups_ids), values(local.third_level_groups_ids), values(local.forth_level_groups_ids))
  )
}
#################################################################
# Get ALL groups to collect all ids and full_paths
#################################################################
data "http" "get_groups_plus" {
  depends_on = [local.created_groups_with_ids]
  url        = "${var.url}${var.api}groups?pagination=keyset&per_page=${var.perpage}&order_by=id"
  request_headers = {
    Authorization = "Bearer ${var.token}"
  }
}
locals {
  all_groups_with_id = { for group in jsondecode(data.http.get_groups_plus.body) : group.id => group.full_path }
}