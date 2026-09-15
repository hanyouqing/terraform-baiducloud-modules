variable "log_stores" {
  type = map(object({
    log_store_name = string
    retention      = number
  }))
  description = "BLS log stores used as the Terraform-supported observability backend"
  default     = {}
}

variable "sms_signatures" {
  type = map(object({
    content               = string
    content_type          = string
    country_type          = optional(string, "DOMESTIC")
    description           = optional(string, null)
    signature_file_base64 = optional(string, null)
    signature_file_format = optional(string, null)
  }))
  description = "Optional SMS signatures for alert channels"
  default     = {}
}

variable "sms_templates" {
  type = map(object({
    name         = string
    content      = string
    sms_type     = string
    country_type = string
    description  = string
  }))
  description = "Optional SMS templates for BCM / on-call notifications"
  default     = {}
}

variable "bcm_checklist" {
  type        = list(string)
  description = "Override BCM Console checklist items exported as an output"
  default     = []
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
