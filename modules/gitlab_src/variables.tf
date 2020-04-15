variable "token" {
    description = "GitLab personal access token"
    type = string
}
variable "url" {
    description = "Target GitLab base API endpoint. Providing a value is a requirement when working with GitLab CE or GitLab Enterprise e.g. https://my.gitlab.server/api/v4/"
type    = string
}