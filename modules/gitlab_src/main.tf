terraform {
  required_version = ">= 0.12"
  required_providers {
    gitlab = "~> 2.6"
  }
}

provider "gitlab" {
  token    = var.token
  base_url = "${var.url}${var.api}"
}

data "http" "get_groups" {
  url = "${var.url}${var.api}groups?per_page=100"
  request_headers = {
    Authorization = "Bearer ${var.token}"
  }
}
locals {
  groups = jsondecode(data.http.get_groups.body)
}
data "http" "get_groups_projects" {
  depends_on = [data.http.get_groups]
  count      = length(local.groups)
  url        = "${var.url}${var.api}groups/${local.groups[count.index].id}/projects?per_page=100"
  request_headers = {
    Authorization = "Bearer ${var.token}"
  }
}