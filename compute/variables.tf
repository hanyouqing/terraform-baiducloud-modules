variable "instances" {
  type = map(object({
    name                       = string
    image_id                   = string
    availability_zone          = string
    subnet_id                  = string
    instance_spec              = optional(string, null)
    cpu_count                  = optional(number, null)
    memory_capacity_in_gb      = optional(number, null)
    payment_timing             = optional(string, "Postpaid")
    root_disk_size_in_gb       = optional(number, 40)
    root_disk_storage_type     = optional(string, "cloud_hp1")
    security_groups            = optional(list(string), [])
    enterprise_security_groups = optional(list(string), [])
    keypair_id                 = optional(string, null)
    admin_pass                 = optional(string, null)
    hostname                   = optional(string, null)
    description                = optional(string, "")
    user_data                  = optional(string, null)
    action                     = optional(string, "start")
    related_release_flag       = optional(bool, false)
    stop_with_no_charge        = optional(bool, false)
    resource_group_id          = optional(string, null)
    cds_disks = optional(list(object({
      cds_size_in_gb = number
      storage_type   = optional(string, "cloud_hp1")
      snapshot_id    = optional(string, null)
    })), [])
    reservation = optional(object({
      reservation_length    = number
      reservation_time_unit = optional(string, "Month")
    }), null)
    eip_key = optional(string, null)
  }))
  description = "Map of BCC instances to create. Prefer instance_spec for modern shapes. Do not commit admin_pass values."
  default     = {}

  validation {
    condition = alltrue([
      for i in var.instances : contains(["Postpaid", "Prepaid"], i.payment_timing)
    ])
    error_message = "payment_timing must be Postpaid or Prepaid."
  }
}

variable "eips" {
  type = map(object({
    name              = optional(string, null)
    bandwidth_in_mbps = number
    payment_timing    = optional(string, "Postpaid")
    billing_method    = optional(string, "ByTraffic")
    route_type        = optional(string, "BGP")
  }))
  description = "Optional EIPs created by this module and associated via instances.*.eip_key"
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
  description = "Additional tags to apply to all resources"
  default     = {}
}
