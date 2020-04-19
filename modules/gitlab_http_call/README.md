# Gitlab API HTTP call to fetch some data

## Supports

### Get ALL Groups

output "groups"

list of maps

```bash
{
    "description" = ""
    "full_name" = "sezon"
    "full_path" = "sezon"
    "id" = 3
    "lfs_enabled" = true
    "name" = "sezon"
    "path" = "sezon"
    "project_creation_level" = "developer"
    "request_access_enabled" = true
    "require_two_factor_authentication" = false
    "share_with_group_lock" = false
    "subgroup_creation_level" = "maintainer"
    "two_factor_grace_period" = 48
    "visibility" = "private"
    "web_url" = "https://gitlab.forbiddenforchildren.com/groups/sezon"
  }
```

### Get ALL Projects

output "projects"

list of maps

```bash
 {
    "created_at" = "2020-04-18T13:09:20.131Z"
    "default_branch" = "master"
    "description" = ""
    "forks_count" = 0
    "http_url_to_repo" = "https://gitlab.forbiddenforchildren.com/kukukuk/frontend/tests/base.git"
    "id" = 17
    "last_activity_at" = "2020-04-18T13:09:20.131Z"
    "name" = "base"
    "name_with_namespace" = "kukukuk / frontend / tests / base"
    "namespace" = {
      "full_path" = "kukukuk/frontend/tests"
      "id" = 31
      "kind" = "group"
      "name" = "tests"
      "parent_id" = 29
      "path" = "tests"
      "web_url" = "https://gitlab.forbiddenforchildren.com/groups/kukukuk/frontend/tests"
    }
    "path" = "base"
    "path_with_namespace" = "kukukuk/frontend/tests/base"
    "readme_url" = "https://gitlab.forbiddenforchildren.com/kukukuk/frontend/tests/base/blob/master/README.md"
    "ssh_url_to_repo" = "git@gitlab.forbiddenforchildren.com:kukukuk/frontend/tests/base.git"
    "star_count" = 0
    "tag_list" = []
    "web_url" = "https://gitlab.forbiddenforchildren.com/kukukuk/frontend/tests/base"
  }
```

## Input

token - GitLab User Access Token with read writes to groups and projects

url   - GitLab URL, eg. `https://gitlab.com`
