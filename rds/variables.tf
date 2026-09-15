variable "instances" {
  type = map(object({
    instance_name          = string
    engine                 = string
    engine_version         = string
    cpu_count              = number
    memory_capacity        = number
    volume_capacity        = number
    disk_io_type           = string
    payment_timing         = optional(string, "Postpaid")
    category               = optional(string, "Standard")
    vpc_id                 = optional(string, null)
    public_access          = optional(bool, false)
    lower_case_table_names = optional(number, null)
    parameter_template_id  = optional(string, null)
    resource_group_id      = optional(string, null)
    backup_days            = optional(string, null)
    backup_time            = optional(string, null)
    replication_type       = optional(string, null)
    auto_renew_time_unit   = optional(string, null)
    auto_renew_time_length = optional(number, null)
    reservation = optional(object({
      reservation_length    = number
      reservation_time_unit = optional(string, "Month")
    }), null)
    subnets = optional(list(object({
      subnet_id = string
      zone_name = string
    })), [])
  }))
  description = "Map of RDS primary instances. public_access defaults to false for production safety."
  default     = {}

  validation {
    condition = alltrue([
      for i in var.instances : contains(["MySQL", "SQLServer", "PostgreSQL"], i.engine)
    ])
    error_message = "engine must be MySQL, SQLServer, or PostgreSQL."
  }

  validation {
    condition = alltrue([
      for i in var.instances : contains(["normal_io", "cloud_high", "cloud_nor", "cloud_enha"], i.disk_io_type)
    ])
    error_message = "disk_io_type must be normal_io, cloud_high, cloud_nor, or cloud_enha."
  }
}

variable "readonly_instances" {
  type = map(object({
    instance_name          = string
    source_instance_key    = optional(string, null)
    source_instance_id     = optional(string, null)
    cpu_count              = number
    memory_capacity        = number
    volume_capacity        = number
    vpc_id                 = string
    payment_timing         = optional(string, "Postpaid")
    category               = optional(string, null)
    auto_renew_time_unit   = optional(string, null)
    auto_renew_time_length = optional(number, null)
    reservation = optional(object({
      reservation_length    = number
      reservation_time_unit = optional(string, "Month")
    }), null)
    subnets = optional(list(object({
      subnet_id = string
      zone_name = string
    })), [])
  }))
  description = "Map of RDS read replicas. Set source_instance_key (module map key) or source_instance_id."
  default     = {}

  validation {
    condition = alltrue([
      for i in var.readonly_instances :
      (i.source_instance_key != null) != (i.source_instance_id != null)
    ])
    error_message = "Each readonly instance must set exactly one of source_instance_key or source_instance_id."
  }
}

variable "accounts" {
  type = map(object({
    instance_key = optional(string, null)
    instance_id  = optional(string, null)
    account_name = string
    password     = string
    account_type = optional(string, null)
    desc         = optional(string, null)
  }))
  description = "Map of RDS database accounts. Prefer injecting password via TF_VAR / secret store — never commit secrets."
  default     = {}

  validation {
    condition = alltrue([
      for a in var.accounts :
      (a.instance_key != null) != (a.instance_id != null)
    ])
    error_message = "Each account must set exactly one of instance_key or instance_id."
  }
}

variable "security_ips" {
  type = map(object({
    instance_key = optional(string, null)
    instance_id  = optional(string, null)
    security_ips = set(string)
  }))
  description = "Whitelist security IPs / CIDRs per primary instance."
  default     = {}

  validation {
    condition = alltrue([
      for s in var.security_ips :
      (s.instance_key != null) != (s.instance_id != null)
    ])
    error_message = "Each security_ips entry must set exactly one of instance_key or instance_id."
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
