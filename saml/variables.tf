variable "account_id" {
  type        = string
  description = "Baidu Cloud account ID used in SAML attribute templates"
  default     = null
}

variable "federation_mode" {
  type        = string
  description = "Primary federation mode: user, role, or both"
  default     = "both"

  validation {
    condition     = contains(["user", "role", "both"], var.federation_mode)
    error_message = "federation_mode must be user, role, or both."
  }
}

variable "identity_providers" {
  type = map(object({
    provider_name   = string
    idp_type        = optional(string, "saml") # documentation only
    metadata_source = optional(string, null)   # path/URL note for operators
    account_id      = optional(string, null)
    description     = optional(string, null)
    enabled         = optional(bool, true)
  }))
  description = "Documented IdP inventory (created in Console — no TF resource yet)"
  default     = {}
}

variable "user_sso_checklist" {
  type        = list(string)
  description = "Override IAM user-federation Console checklist"
  default     = []
}

variable "role_sso_checklist" {
  type        = list(string)
  description = "Override IAM role-SSO Console checklist"
  default     = []
}

variable "project" {
  type        = string
  description = "Project name"
  default     = "baiducloud-modules"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "development"
}

variable "tags" {
  type        = map(string)
  description = "Recommended tags for Console IdP/role objects"
  default     = {}
}
