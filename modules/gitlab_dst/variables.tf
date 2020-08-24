variable "token" {
  description = "required: GitLab personal access token"
  default     = ""
}
variable "url" {
  description = "required: Target GitLab base API endpoint. Providing a value is a requirement when working with GitLab CE or GitLab Enterprise e.g. https://my.gitlab.server/api/v4/"
  default     = ""
}

variable "api" {
  description = "postfix API"
  default     = "/api/v4/"
}

variable "set_groups" {
  description = "Flag to get list of groups to print it on output"
  default     = true
}
variable "groups" {
  description = "required: Map of groups to be cloned"
  default     = []
}
variable "perpage" {
  description = "set number of projects to return"
  default     = 1000
}
variable "log_filepath" {
  description = "Full path to git_clone.py log filepath"
  default     = "./git_clone.log"
}

variable "upload_projects" {
  description = "requiered: list of maps { project_ssh_url = project_ssh_namespace_full_path}, eg. { \"git@gitlab.mysite.com\" = \"group/subgroup\" } if project has empty project_ssh_namespace_full_path, it will be force pushed to the user owner of gitlab access token "
  type        = list(map(string))
}
variable "workdir" {
  description = "required: folder where all git repos of pushed projects are placed, var.workdir/zero_group/first_level_group/... will be used"
  default     = "/tmp"
}