variable "log_stores" {
  type = map(object({
    log_store_name = string
    retention      = number
  }))
  description = "Map of BLS log stores. retention is days."
  default     = {}

  validation {
    condition = alltrue([
      for s in var.log_stores : s.retention >= 1 && s.retention <= 3650
    ])
    error_message = "retention must be between 1 and 3650 days."
  }
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
