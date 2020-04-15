terraform {
    required_version = ">= 0.12"
    required_providers {
                    gitlab = "~> 2.6"
                    }
}

provider "gitlab" {
  token = var.token
  base_url = var.url
}