variable "eips" {
  type = map(object({
    name                  = optional(string, null)
    bandwidth_in_mbps     = number
    payment_timing        = optional(string, "Postpaid")
    billing_method        = optional(string, "ByTraffic")
    route_type            = optional(string, "BGP")
    reservation_length    = optional(number, null)
    reservation_time_unit = optional(string, null)
    auto_renew_time       = optional(number, null)
    auto_renew_time_unit  = optional(string, null)
  }))
  description = "Map of EIPs to create"
  default     = {}

  validation {
    condition = alltrue([
      for e in var.eips :
      contains(["Postpaid", "Prepaid"], e.payment_timing) &&
      contains(["ByTraffic", "ByBandwidth"], e.billing_method) &&
      contains(["BGP", "BGP_S"], e.route_type)
    ])
    error_message = "Invalid EIP payment_timing, billing_method, or route_type."
  }
}

variable "associations" {
  type = map(object({
    eip_key       = string
    instance_id   = string
    instance_type = string
  }))
  description = "Optional EIP associations. instance_type: BCC, BLB, NAT, VPN"
  default     = {}

  validation {
    condition = alltrue([
      for a in var.associations : contains(["BCC", "BLB", "NAT", "VPN"], a.instance_type)
    ])
    error_message = "instance_type must be BCC, BLB, NAT, or VPN."
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
