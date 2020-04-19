
terraform {
  required_version = ">= 0.12"
  required_providers {
    http = "~> 1.2"
  }
}
#####################################################
# Get ALL Groups
#####################################################
data "http" "get_groups" {
  depends_on = [var.ghc_depends_on]
  url        = "${var.url}${var.api}groups?pagination=keyset&per_page=${var.perpage}&order_by=id"
  request_headers = {
    Authorization = "Bearer ${var.token}"
  }
}
#####################################################
# Get ALL Projects
#####################################################
data "http" "get_projects" {
  url = "${var.url}${var.api}projects?pagination=keyset&per_page=${var.perpage}&order_by=id&simple=true"

  request_headers = {
    Authorization = "Bearer ${var.token}"
  }
}