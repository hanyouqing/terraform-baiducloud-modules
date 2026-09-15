variable "name" {
  type        = string
  description = "BLB instance name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the BLB"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the BLB"
}

variable "description" {
  type        = string
  description = "BLB description"
  default     = "Managed by Terraform"
}

variable "payment_timing" {
  type        = string
  description = "Postpaid or Prepaid"
  default     = "Postpaid"
}

variable "performance_level" {
  type        = string
  description = "Performance level: small1, small2, medium1, medium2, large1, large2, large3"
  default     = null
}

variable "security_groups" {
  type        = list(string)
  description = "Security group IDs"
  default     = []
}

variable "allocate_ipv6" {
  type        = bool
  description = "Whether to allocate IPv6"
  default     = false
}

variable "allow_delete" {
  type        = bool
  description = "Whether the BLB can be deleted"
  default     = true
}

variable "listeners" {
  type = map(object({
    listener_port                  = number
    backend_port                   = number
    protocol                       = string
    scheduler                      = string
    health_check_interval          = optional(number, null)
    health_check_timeout_in_second = optional(number, null)
    health_check_type              = optional(string, null)
    health_check_uri               = optional(string, null)
    health_check_port              = optional(number, null)
    health_check_string            = optional(string, null)
    healthy_threshold              = optional(number, null)
    server_timeout                 = optional(number, null)
    keep_session                   = optional(bool, null)
    cert_ids                       = optional(list(string), null)
  }))
  description = "Map of BLB listeners"
  default     = {}

  validation {
    condition = alltrue([
      for l in var.listeners : contains(["TCP", "UDP", "HTTP", "HTTPS", "SSL"], l.protocol)
    ])
    error_message = "listener protocol must be TCP, UDP, HTTP, HTTPS, or SSL."
  }
}

variable "backend_servers" {
  type = list(object({
    instance_id = string
    weight      = number
  }))
  description = "Backend BCC instance list for the BLB"
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
  description = "Additional tags to apply to all resources"
  default     = {}
}
