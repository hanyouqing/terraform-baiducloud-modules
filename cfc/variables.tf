variable "functions" {
  type = map(object({
    function_name                  = string
    handler                        = string
    runtime                        = string
    time_out                       = number
    description                    = optional(string, null)
    memory_size                    = optional(number, 128)
    reserved_concurrent_executions = optional(number, null)
    environment                    = optional(map(string), {})
    code_file_name                 = optional(string, null)
    code_file_dir                  = optional(string, null)
    code_bos_bucket                = optional(string, null)
    code_bos_object                = optional(string, null)
    log_type                       = optional(string, null)
    log_bos_dir                    = optional(string, null)
    publish_version                = optional(bool, false)
    version_description            = optional(string, null)
    vpc_config = optional(object({
      vpc_id             = string
      subnet_ids         = set(string)
      security_group_ids = set(string)
    }), null)
  }))
  description = "Map of CFC (serverless) functions. Provide exactly one code source (file/dir/BOS)."
  default     = {}
}

variable "aliases" {
  type = map(object({
    alias_name       = string
    function_key     = optional(string, null)
    function_name    = optional(string, null)
    function_version = string
    description      = optional(string, null)
  }))
  description = "CFC aliases. Use function_version=\"published\" with function_key to pin to the published version resource."
  default     = {}
}

variable "triggers" {
  type = map(object({
    source_type         = string
    function_key        = optional(string, null)
    target              = optional(string, null)
    name                = optional(string, null)
    enabled             = optional(string, null)
    schedule_expression = optional(string, null)
    bucket              = optional(string, null)
    bos_event_type      = optional(list(string), [])
    resource            = optional(string, null)
    domain              = optional(string, null)
    cdn_event_type      = optional(string, null)
    method              = optional(set(string), [])
    auth_type           = optional(string, null)
    resource_path       = optional(string, null)
    input               = optional(string, null)
    remark              = optional(string, null)
    status              = optional(string, null)
  }))
  description = "CFC triggers (cron / BOS / CDN / HTTP). Set function_key or target BRN."
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
  description = "Additional tags (informational; CFC resources do not accept tags today)"
  default     = {}
}
