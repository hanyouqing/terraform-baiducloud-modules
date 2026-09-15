variable "certificates" {
  type = map(object({
    cert_name         = string
    cert_server_data  = string
    cert_private_data = string
    cert_link_data    = optional(string, null)
    cert_type         = optional(string, null)
  }))
  description = "Map of uploaded TLS certificates (PEM data should be base64-encoded as required by the provider)"
  default     = {}
  sensitive   = true
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
