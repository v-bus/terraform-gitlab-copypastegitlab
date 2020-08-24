
terraform {
  required_version = ">= 0.13"
  required_providers {
    gitlab = {
      source  = "terraform-providers/gitlab"
      version = "~> 2.6"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 1.2"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 1.2"
    }
  }
}