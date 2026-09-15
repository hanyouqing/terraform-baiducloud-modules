variable "instances" {
  type = map(object({
    service_id           = string
    region_id            = string
    image_id             = string
    cpu                  = number
    memory               = number
    vm_name              = optional(string, null)
    host_name            = optional(string, null)
    image_type           = optional(string, "bcc")
    need_public_ip       = optional(bool, false)
    need_ipv6_public_ip  = optional(bool, false)
    bandwidth            = optional(number, null)
    network_type         = optional(string, "vpc")
    vpc_id               = optional(string, null)
    subnet_id            = optional(string, null)
    payment_method       = optional(string, null)
    spec                 = optional(string, null)
    dns_type             = optional(string, "DEFAULT")
    dns_address          = optional(list(string), null)
    key_type             = optional(string, "bccKeyPair")
    admin_pass           = optional(string, null)
    bcc_key_pair_id_list = optional(list(string), [])
    system_volume = object({
      name        = string
      size_in_gb  = number
      volume_type = string
    })
    data_volumes = optional(list(object({
      name        = string
      size_in_gb  = number
      volume_type = string
    })), [])
  }))
  description = "Map of BEC (edge / lightweight) VM instances"
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
