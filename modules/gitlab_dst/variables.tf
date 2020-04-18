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