variable "token" {
    description = "required: GitLab personal access token"
    default = ""
}
variable "url" {
    description = "required: Target GitLab base API endpoint. Providing a value is a requirement when working with GitLab CE or GitLab Enterprise e.g. https://my.gitlab.server/api/v4/"
    default = ""
}

variable "api" {
  description = "postfix API"
  default = "/api/v4/"
}
