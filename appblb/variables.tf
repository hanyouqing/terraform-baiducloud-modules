variable "name" {
  type        = string
  description = "APPBLB name"
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "description" {
  type    = string
  default = "Managed by Terraform"
}

variable "payment_timing" {
  type    = string
  default = "Postpaid"
}

variable "performance_level" {
  type    = string
  default = null
}

variable "security_groups" {
  type    = list(string)
  default = []
}

variable "server_groups" {
  type = map(object({
    name        = string
    description = optional(string, "")
  }))
  description = "Application BLB server groups"
  default     = {}
}

variable "listeners" {
  type = map(object({
    listener_port = number
    protocol      = string
    scheduler     = optional(string, "RoundRobin")
  }))
  description = "APPBLB listeners (protocol typically HTTP/HTTPS/TCP)"
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
