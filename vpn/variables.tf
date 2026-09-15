variable "vpn_name" {
  type        = string
  description = "VPN gateway name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the VPN gateway"
}

variable "payment_timing" {
  type        = string
  description = "Postpaid or Prepaid"
  default     = "Postpaid"
}

variable "description" {
  type        = string
  description = "VPN gateway description"
  default     = "Managed by Terraform"
}

variable "eip" {
  type        = string
  description = "Optional EIP address to bind to the VPN gateway"
  default     = null
}

variable "create_eip" {
  type        = bool
  description = "Create and bind an EIP for the VPN gateway"
  default     = false
}

variable "eip_bandwidth_in_mbps" {
  type        = number
  description = "Bandwidth for managed VPN EIP"
  default     = 100
}

variable "connections" {
  type = map(object({
    vpn_conn_name  = string
    secret_key     = string
    local_subnets  = list(string)
    remote_ip      = string
    remote_subnets = list(string)
    description    = optional(string, "")
    ike_config = optional(object({
      ike_version   = string
      ike_mode      = string
      ike_enc_alg   = string
      ike_auth_alg  = string
      ike_pfs       = string
      ike_life_time = number
    }), null)
    ipsec_config = optional(object({
      ipsec_enc_alg   = string
      ipsec_auth_alg  = string
      ipsec_pfs       = string
      ipsec_life_time = number
    }), null)
  }))
  description = "Map of IPSec VPN connections. Do not commit secret_key values."
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
