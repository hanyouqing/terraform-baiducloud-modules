variable "domains" {
  type = map(object({
    domain       = string
    form         = optional(string, "default")
    default_host = optional(string, null)
    origins = list(object({
      addr              = string
      type              = string
      backup            = optional(bool, false)
      host              = optional(string, null)
      weight            = optional(number, null)
      isp               = optional(string, null)
      http_port         = optional(number, null)
      https_port        = optional(number, null)
      upstream_protocol = optional(string, null)
    }))
  }))
  description = "Map of CDN acceleration domains with origins"
  default     = {}
}

variable "project" {
  type        = string
  description = "Project name for tagging"
  default     = "baiducloud-modules"
}

variable "environment" {
  type        = string
  description = "Environment name for tagging"
  default     = "development"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags"
  default     = {}
}
