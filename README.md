# terraform module to copy gotlab projects from one gitlab server and paste it to another gitlab server

## reasons to use

It's happen when you didn't update gitlab for a long time and whants to migrate you projects to a new gitlab server with much higher version. Gitlab Import/Export doesn't work due to incpmatibility of gitlab versions.

## quickstart

1. install Terraform (see [versoins.tf](versions.tf) to check required versions)
1. `git clone` this module
1. set required variables in .tfvars file (see [variables.tf](variables.tf) file, required variables labeled as required)
1. run `terraform init`
1. run `terraform plan`

## using from your terraform code

example

```terraform
module "gp_copy_paste" {
    source = "https://github.com/v-bus/terraform-gitlab-copypastegitlab"
}

```

```bash
curl -k --header "Authorization: Bearer $TOKEN"  https://gitlab.XXXXXXX.com/api/v4/groups/26/projects?per_page=100 | jq '.[] | .ssh_url_to_repo'

curl -k --header "Authorization: Bearer $TOKEN"  https://gitlab.XXXXXXX.com/api/v4/groups?per_page=100 | jq '.[] | "\(.id) \(.full_path)"'

```

## Example Usage

1. As always, create and activate a venv_.

```bash
      python -m venv env
      source env/bin/activate
```

1. Install `terraform_external_data` and `json-logging` in the env.

```bash
      pip install terraform_external_data
      pip install json-logging
```

[pip install terraform_external_data](https://github.com/operatingops/terraform_external_data)

[pip install json-logging](https://github.com/cloudreach/jsonlogger)

1. Add .tfvars file with `token` and `url` to modules/gitlab_src and modules/gitlab_dst folder

1. Try first `terraform apply -var-file=<your.tfvars>` to get groups array in output

1. Add given groups array to .tfvars file with only that goup names you whant to clone

### NOTE: !@#$%^& are not supported in project names only [a-zA-Z0-9-_]
