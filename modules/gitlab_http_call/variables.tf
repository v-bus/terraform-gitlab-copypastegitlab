variable "perpage" {
  description = "set number of projects to return"
  default     = 1000
}
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

variable "ghc_depends_on" {
  description = "required: sould point to another submodule (https://discuss.hashicorp.com/t/tips-howto-implement-module-depends-on-emulation/2305/2)"
  type        = any
  default     = null
}