variable "gitlab_src_token" {
    description = "required: Source GitLab (from) personal access token"
    default = ""
}

variable "gitlab_dst_token" {
    description = "required: Destination GitLab (to) personal access token"
    default = ""
}

variable "gitlab_src_url" {
    description = "required: Source GitLab (from) URL https://gitlab.mydomainA.com"
default = ""
}
variable "gitlab_dst_url" {
    description = "required: Destination GitLab (to) URL https://gitlab.mydomainB.com"
default = ""
}