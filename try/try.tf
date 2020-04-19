variable "upload_projects" {
default = [
  {
    "git@gitlab.forbiddenforchildren.com:kukukuk/frontend/tests/base.git" = "kukukuk1/frontend/tests"
  },
  {
    "git@gitlab.forbiddenforchildren.com:kukukuk/frontend/tests/echos.git" = "kukukuk1/frontend/tests"
  },
  {
    "git@gitlab.forbiddenforchildren.com:kukukuk/frontend/base.git" = "kukukuk1/frontend"
  },
  {
    "git@gitlab.forbiddenforchildren.com:kukukuk/frontend/loop.git" = "kukukuk1/frontend"
  },
  {
    "git@gitlab.forbiddenforchildren.com:kukukuk/backend/nosql.git" = "kukukuk1/backend"
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
    "git@gitlab.forbiddenforchildren.com:sezon/landsat/landsat-downlo_ade^r.git" = "sezon2/landsat"
  },
]
}

output res {
    #value = [for str in var.upload_projects:regex("(\\w*).",regex("([^/]+)/?$", keys(str)[0])[0])] 
    value = [for str in var.upload_projects:replace(keys(str)[0], "/[^:]*:(.*).git/", "$1") ]
}
output str {
    value = [for str in var.upload_projects:keys(str)[0]] 
}
output str1 {
  value = split("/", "kukukuk1/frontend/tests")[1]
}