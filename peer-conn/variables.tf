variable "connections" {
  type = map(object({
    bandwidth_in_mbps = number
    local_vpc_id      = string
    peer_vpc_id       = string
    peer_region       = string
    payment_timing    = optional(string, "Postpaid")
    description       = optional(string, "")
    dns_sync          = optional(bool, null)
    local_if_name     = optional(string, null)
    peer_if_name      = optional(string, null)
    peer_account_id   = optional(string, null)
    reservation = optional(object({
      reservation_length    = number
      reservation_time_unit = optional(string, "Month")
    }), null)
  }))
  description = "Map of VPC peer connections"
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
