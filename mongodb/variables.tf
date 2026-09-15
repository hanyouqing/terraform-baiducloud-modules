variable "replica_instances" {
  type = map(object({
    name                    = optional(string, null)
    cpu_count               = number
    memory_capacity         = number
    storage                 = number
    storage_type            = optional(string, null)
    storage_engine          = optional(string, null)
    engine_version          = optional(string, null)
    payment_timing          = optional(string, "Postpaid")
    account_password        = optional(string, null)
    vpc_id                  = optional(string, null)
    security_ip             = optional(set(string), [])
    voting_member_num       = optional(number, null)
    readonly_node_num       = optional(number, null)
    auto_backup_enable      = optional(string, null)
    preferred_backup_period = optional(set(string), [])
    preferred_backup_time   = optional(string, null)
    enable_increment_backup = optional(number, null)
    reservation_length      = optional(number, null)
    auto_renew_length       = optional(number, null)
    resource_group_id       = optional(string, null)
    subnets = optional(list(object({
      subnet_id = string
      zone_name = string
    })), [])
  }))
  description = "Map of MongoDB replica-set instances (DocDB). Passwords via TF_VAR — never commit."
  default     = {}
}

variable "sharding_instances" {
  type = map(object({
    name                   = optional(string, null)
    mongos_count           = number
    mongos_cpu_count       = number
    mongos_memory_capacity = number
    shard_count            = number
    shard_cpu_count        = number
    shard_memory_capacity  = number
    shard_storage          = number
    shard_storage_type     = optional(string, null)
    storage_engine         = optional(string, null)
    engine_version         = optional(string, null)
    payment_timing         = optional(string, "Postpaid")
    account_password       = optional(string, null)
    vpc_id                 = optional(string, null)
    security_ip            = optional(set(string), [])
    reservation_length     = optional(number, null)
    auto_renew_length      = optional(number, null)
    resource_group_id      = optional(string, null)
    subnets = optional(list(object({
      subnet_id = string
      zone_name = string
    })), [])
  }))
  description = "Map of MongoDB sharding cluster instances"
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
