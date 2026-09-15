variable "users" {
  type = map(object({
    name              = string
    description       = optional(string, null)
    force_destroy     = optional(bool, false)
    create_access_key = optional(bool, false)
    pgp_key           = optional(string, null)
    secret_file       = optional(string, null)
  }))
  description = "Map of IAM users. Prefer pgp_key/secret_file for access-key secrets."
  default     = {}
}

variable "policies" {
  type = map(object({
    name        = string
    document    = string
    description = optional(string, null)
  }))
  description = "Map of custom IAM policies (JSON ACL document string)"
  default     = {}
}

variable "user_policy_attachments" {
  type = map(object({
    user_key    = string
    policy_key  = optional(string, null)
    policy_name = optional(string, null)
    policy_type = optional(string, null)
  }))
  description = "Attach custom (policy_key) or system (policy_name) policies to users"
  default     = {}

  validation {
    condition = alltrue([
      for a in var.user_policy_attachments :
      (a.policy_key != null) != (a.policy_name != null)
    ])
    error_message = "Each user_policy_attachment must set exactly one of policy_key or policy_name."
  }
}

variable "groups" {
  type = map(object({
    name          = string
    description   = optional(string, null)
    force_destroy = optional(bool, false)
    user_keys     = optional(list(string), [])
    # Backward-compatible short form: list of module policy keys
    policy_keys = optional(list(string), [])
    # Explicit attachments (custom or system policies)
    policy_attachments = optional(list(object({
      policy_key  = optional(string, null)
      policy_name = optional(string, null)
      policy_type = optional(string, null)
    })), [])
  }))
  description = "Map of IAM groups with memberships and policy attachments"
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
