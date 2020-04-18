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

```bash
curl -k --header "Authorization: Bearer $TOKEN"  https://gitlab.XXXXXXX.com/api/v4/groups/26/projects?per_page=100 | jq '.[] | .ssh_url_to_repo'

curl -k --header "Authorization: Bearer $TOKEN"  https://gitlab.XXXXXXX.com/api/v4/groups?per_page=100 | jq '.[] | "\(.id) \(.full_path)"'

```

[pip install terraform_external_data](https://github.com/operatingops/terraform_external_data)

[pip install json-logging](https://github.com/cloudreach/jsonlogger)