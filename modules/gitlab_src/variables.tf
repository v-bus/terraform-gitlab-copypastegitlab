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
variable "groups" {
    description = "required: Map of groups to be cloned"
    default = {
    "" = ""
  }
}