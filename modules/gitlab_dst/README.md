# gitlab destination submodule

force push all branches to specified project ssh url

project ssh url can contain subgroup namespaces or user namespace (whith user namespace be shure you token has administrator access to gitlab resource)

## project input variable

Example

```tfvars
upload_projects = [
  {
    "git@gitlab.forbiddenforchildren.com:kukukuk/frontend/tests/base.git" = "kukukuk/frontend/tests"
  },
  {
    "git@gitlab.forbiddenforchildren.com:kukukuk/frontend/tests/echos.git" = "kukukuk/frontend/tests"
  },
  {
    "git@gitlab.forbiddenforchildren.com:kukukuk/frontend/base.git" = "kukukuk/frontend"
  },
  {
    "git@gitlab.forbiddenforchildren.com:kukukuk/frontend/loop.git" = "kukukuk/frontend"
  },
  {
    "git@gitlab.forbiddenforchildren.com:kukukuk/backend/nosql.git" = "kukukuk/backend"
  },
  {
    "git@gitlab.forbiddenforchildren.com:kukukuk/backend/python.git" = "kukukuk/backend"
  },
  {
    "git@gitlab.forbiddenforchildren.com:kukukuk/backend/db.git" = "kukukuk/backend"
  },
  {
    "git@gitlab.forbiddenforchildren.com:kukukuk/frontend/cache.git" = "kukukuk/frontend"
  },
  {
    "git@gitlab.forbiddenforchildren.com:kukukuk/frontend/web.git" = "kukukuk/frontend"
  },
  {
    "git@gitlab.forbiddenforchildren.com:sezon/landsat/landsat-downloader.git" = "sezon/landsat"
  },
]
```

## group list input variable

Example

```tfvars
groups = [
  "kukukuk1",
  "kukukuk1/frontend",
  "sezon1",
  "kukukuk1/backend",
  "kukukuk1/frontend/tests",
  "kukukuk1/frontend/tests/bingo",
  "kukukuk1/frontend/tests/bingo/langosts",
  "sezon1/landsat",
]
```

### NOTE: groups and projects can contains different names

At the first step groups will be produced

Submodule supports 5-th level entrance groups

```bash
group                                                   # zero level
group/subgroup                                          # 1st level
group/subgroup/subgroup/subgroup                        # 2nd level
group/subgroup/subgroup/subgroup/subgroup               # 3rd level
group/subgroup/subgroup/subgroup/subgroup/subgroup      # 4th level
```
