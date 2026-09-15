variable "volumes" {
  type = map(object({
    name                  = optional(string, null)
    description           = optional(string, "")
    payment_timing        = optional(string, "Postpaid")
    disk_size_in_gb       = optional(number, null)
    storage_type          = optional(string, "hp1")
    zone_name             = optional(string, null)
    snapshot_id           = optional(string, null)
    instance_id           = optional(string, null)
    auto_snapshot         = optional(bool, null)
    manual_snapshot       = optional(bool, null)
    resource_group_id     = optional(string, null)
    reservation_length    = optional(number, null)
    reservation_time_unit = optional(string, null)
    attach_instance_id    = optional(string, null)
  }))
  description = "Map of CDS volumes. Use attach_instance_id for separate attachment resource."
  default     = {}

  validation {
    condition = alltrue([
      for v in var.volumes :
      v.snapshot_id != null || (v.disk_size_in_gb != null && v.disk_size_in_gb >= 5 && v.disk_size_in_gb <= 32765)
    ])
    error_message = "Each volume needs snapshot_id or disk_size_in_gb between 5 and 32765."
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
  description = "Additional tags to apply to all resources"
  default     = {}
}
