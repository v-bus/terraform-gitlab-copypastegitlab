variable "token" {
  description = "required: GitLab personal access token"
  type        = string
}
variable "url" {
  description = "required: Target GitLab base API endpoint. Providing a value is a requirement when working with GitLab CE or GitLab Enterprise e.g. https://my.gitlab.server/api/v4/"
  type        = string
}

variable "api" {
  description = "postfix API"
  default     = "/api/v4/"
}
variable "get_groups" {
  description = "Flag to get list of groups to print it on output"
  default     = true
}
variable "groups" {
  description = "required: Map of groups to be cloned"
  default     = []
}
variable "project_total_number" {
  description = "total numer of your gitlab projects"
  default     = 303
}
variable "log_filepath" {
  description = "Full path to git_clone.py log filepath"
  default     = "./git_clone.log"
}
variable "workdir" {
  description = "required: folder where all git repos will be cloned"
  default     = "/tmp"
}