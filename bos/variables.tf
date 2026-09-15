variable "buckets" {
  type = map(object({
    bucket                      = string
    acl                         = optional(string, "private")
    storage_class               = optional(string, "STANDARD")
    versioning_status           = optional(string, null)
    enable_multi_az             = optional(bool, false)
    force_destroy               = optional(bool, false)
    server_side_encryption_rule = optional(string, null)
    resource_group              = optional(string, null)
    logging = optional(object({
      target_bucket = string
      target_prefix = optional(string, "")
    }), null)
    website = optional(object({
      index_document = string
      error_document = optional(string, null)
    }), null)
    cors_rules = optional(list(object({
      allowed_origins = list(string)
      allowed_methods = list(string)
      allowed_headers = optional(list(string), null)
      max_age_seconds = optional(number, null)
    })), [])
    lifecycle_rules = optional(list(object({
      id                = string
      status            = string
      resource          = list(string)
      action_name       = string
      date_greater_than = string
    })), [])
  }))
  description = "Map of BOS buckets. Default ACL is private (production-safe)."
  default     = {}

  validation {
    condition = alltrue([
      for b in var.buckets : contains(["private", "public-read", "public-read-write"], b.acl)
    ])
    error_message = "acl must be private, public-read, or public-read-write."
  }

  validation {
    condition = alltrue([
      for b in var.buckets : contains([
        "STANDARD", "STANDARD_IA", "MAZ_STANDARD", "MAZ_STANDARD_IA", "COLD", "ARCHIVE"
      ], b.storage_class)
    ])
    error_message = "Invalid storage_class for BOS bucket."
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
