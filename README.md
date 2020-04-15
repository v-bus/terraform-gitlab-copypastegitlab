# terraform module to copy gotlab projects from one gitlab server and paste it to another gitlab server

## reasons to use

It's happen when you didn't update gitlab for a long time and whants to migrate you projects to a new gitlab server with much higher version. Gitlab Import/Export doesn't work due to incpmatibility of gitlab versions.

## quickstart

1. install Terraform (see [project.tf](project.tf) to check required versions)
1. `git clone` this module
1. set required variables in .tfvars file (see [variables.tf](variables.tf) file, required variables labeled as required)
1. run `terraform init`
1. run `terraform plan`

## using from your terraform code

example

```terraform
module "gp_copy_paste" {
    source = "github.com/v-bus/terraform-gitlab-cpypstgitlab"
}

```
