variable "gitlab_src_token" {
    description = "Source GitLab (from) personal access token"
    type = string
}

variable "gitlab_dst_token" {
    description = "Destination GitLab (to) personal access token"
    type = string
}

variable "gitlab_src_url" {
    description = "Source GitLab (from) URL https://gitlab.mydomainA.com/api/v4/"
type    = string
}

variable "gitlab_dst_url" {
    description = "Destination GitLab (to) URL https://gitlab.mydomainB.com/api/v4/"
type    = string
}