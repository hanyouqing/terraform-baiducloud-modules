variable "zones" {
  type = map(object({
    name = string
  }))
  description = "Map of public DNS zones"
  default     = {}
}

variable "records" {
  type = map(object({
    zone_key      = string
    rr            = string
    type          = string
    value         = string
    ttl           = optional(number, 60)
    line          = optional(string, null)
    priority      = optional(number, null)
    description   = optional(string, null)
    record_action = optional(string, null)
  }))
  description = "Map of DNS records. zone_key references zones map key."
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
