variable "signatures" {
  type = map(object({
    content               = string
    content_type          = string
    country_type          = optional(string, "DOMESTIC")
    description           = optional(string, null)
    signature_file_base64 = optional(string, null)
    signature_file_format = optional(string, null)
  }))
  description = "Map of SMS signatures (closest Terraform-supported messaging primitive; email SES is not in the provider)"
  default     = {}
}

variable "templates" {
  type = map(object({
    name         = string
    content      = string
    sms_type     = string
    country_type = string
    description  = string
  }))
  description = "Map of SMS templates for notices/alerts"
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
