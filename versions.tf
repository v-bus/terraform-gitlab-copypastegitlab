
terraform {
  required_version = ">= 0.13"
  required_providers {
    gitlab = {
      source  = "terraform-providers/gitlab"
      version = "~> 2.6"
    }
  }
}