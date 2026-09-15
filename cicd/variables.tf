variable "create_deploy_user" {
  type        = bool
  description = "Create the primary CI/CD deploy IAM user"
  default     = true
}

variable "deploy_user_name" {
  type        = string
  description = "Deploy IAM user name"
  default     = "cicd-deploy"
}

variable "deploy_user_description" {
  type        = string
  description = "Deploy IAM user description"
  default     = "CI/CD deploy service account"
}

variable "create_deploy_access_key" {
  type        = bool
  description = "Create an access key for the deploy user"
  default     = true
}

variable "deploy_policy_name" {
  type        = string
  description = "Deploy policy name"
  default     = "cicd-deploy-policy"
}

variable "deploy_policy_document" {
  type        = string
  description = "Optional custom IAM ACL JSON for the deploy user"
  default     = null
}

variable "policy_region" {
  type        = string
  description = "Region scope used in the default deploy policy"
  default     = "*"
}

variable "create_breakglass_user" {
  type        = bool
  description = "Create an emergency break-glass IAM user (no access key by default)"
  default     = false
}

variable "breakglass_user_name" {
  type        = string
  description = "Break-glass user name"
  default     = "cicd-breakglass"
}

variable "breakglass_user_description" {
  type        = string
  description = "Break-glass user description"
  default     = "Emergency break-glass account"
}

variable "extra_users" {
  type = map(object({
    name              = string
    description       = optional(string, null)
    force_destroy     = optional(bool, false)
    create_access_key = optional(bool, false)
  }))
  description = "Additional IAM users"
  default     = {}
}

variable "extra_policies" {
  type = map(object({
    name        = string
    document    = string
    description = optional(string, null)
  }))
  description = "Additional IAM policies"
  default     = {}
}

variable "extra_user_policy_attachments" {
  type = map(object({
    user_key   = string
    policy_key = string
  }))
  description = "Additional user→policy attachments"
  default     = {}
}

variable "groups" {
  type = map(object({
    name        = string
    description = optional(string, null)
    user_keys   = optional(list(string), [])
    policy_keys = optional(list(string), [])
  }))
  description = "Optional IAM groups"
  default     = {}
}

variable "cfc_functions" {
  type        = any
  description = "Optional CFC functions map (passed to cfc module)"
  default     = {}
}

variable "cfc_aliases" {
  type        = any
  description = "Optional CFC aliases map"
  default     = {}
}

variable "cfc_triggers" {
  type        = any
  description = "Optional CFC triggers map"
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
