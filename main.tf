
provider "gitlab" {
  alias    = "src"
  token    = var.gitlab_src_token
  base_url = var.gitlab_src_url
}
provider "gitlab" {
  alias    = "dst"
  token    = var.gitlab_dst_token
  base_url = var.gitlab_dst_url
}
module "gitlab_src" {
  source = "./modules/gitlab_src"
  providers = {
    gitlab = gitlab.src
  }
}
module "gitlab_dst" {
  source = "./modules/gitlab_dst"
  providers = {
    gitlab = gitlab.dst
  }
}