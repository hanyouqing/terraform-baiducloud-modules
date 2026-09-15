variable "gateways" {
  type = map(object({
    name        = string
    vpc_id      = string
    speed       = number
    description = optional(string, null)
    et_id       = optional(string, null)
    channel_id  = optional(string, null)
    local_cidrs = optional(list(string), null)
  }))
  description = "Map of ET (Express Tunnel / 高速通道) gateways"
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
