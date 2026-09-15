variable "instances" {
  type = map(object({
    instance_name          = string
    node_type              = string
    payment_timing         = optional(string, "Postpaid")
    engine                 = optional(string, "redis")
    engine_version         = optional(string, "6.0")
    cluster_type           = optional(string, "master_slave")
    port                   = optional(number, 6379)
    shard_num              = optional(number, 1)
    replication_num        = optional(number, 1)
    proxy_num              = optional(number, 0)
    client_auth            = optional(string, null)
    vpc_id                 = optional(string, null)
    security_groups        = optional(list(string), [])
    backup_days            = optional(string, null)
    backup_time            = optional(string, null)
    store_type             = optional(number, null)
    disk_flavor            = optional(number, null)
    disk_type              = optional(string, null)
    enable_read_only       = optional(number, null)
    reservation_length     = optional(number, null)
    reservation_time_unit  = optional(string, null)
    auto_renew             = optional(bool, null)
    auto_renew_time_unit   = optional(string, null)
    auto_renew_time_length = optional(number, null)
    resource_group_id      = optional(string, null)
    subnets = optional(list(object({
      subnet_id = string
      zone_name = string
    })), [])
    replication_info = optional(list(object({
      availability_zone = string
      subnet_id         = string
      is_master         = bool
    })), [])
  }))
  description = "Map of SCS (Redis/Memcache/PegaDB) instances. Do not commit client_auth values."
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
