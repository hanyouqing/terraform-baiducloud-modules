variable "organization" {
  type        = string
  description = "Enterprise organization display name"
}

variable "account_name" {
  type = string
}

variable "account_type" {
  type        = string
  description = "management | security | shared | workload"
  validation {
    condition     = contains(["management", "security", "shared", "workload"], var.account_type)
    error_message = "account_type must be management, security, shared, or workload."
  }
}

variable "environment" {
  type = string
}

variable "project" {
  type = string
}

variable "cost_center" {
  type    = string
  default = null
}

variable "owner" {
  type    = string
  default = null
}

variable "extra_tags" {
  type    = map(string)
  default = {}
}
