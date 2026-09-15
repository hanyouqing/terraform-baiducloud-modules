variable "name" {
  type        = string
  description = "Name of the VPC (cannot be \"default\")"
  default     = "vpc"

  validation {
    condition     = var.name != "default" && length(var.name) >= 1 && length(var.name) <= 65
    error_message = "VPC name must be 1-65 characters and cannot be \"default\"."
  }
}

variable "cidr" {
  type        = string
  description = "Primary CIDR block for the VPC"
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrnetmask(var.cidr))
    error_message = "cidr must be a valid IPv4 CIDR."
  }
}

variable "description" {
  type        = string
  description = "Description of the VPC"
  default     = "Managed by Terraform"
}

variable "enable_ipv6" {
  type        = bool
  description = "Whether to enable IPv6 for the VPC"
  default     = false
}

variable "enable_relay" {
  type        = bool
  description = "Whether to enable route relay for the VPC"
  default     = false
}

variable "secondary_cidrs" {
  type        = list(string)
  description = "Secondary CIDR blocks for the VPC"
  default     = []

  validation {
    condition     = alltrue([for c in var.secondary_cidrs : can(cidrnetmask(c))])
    error_message = "All secondary_cidrs must be valid IPv4 CIDRs."
  }
}

variable "public_subnets" {
  type = map(object({
    name        = string
    cidr        = string
    zone_name   = string
    description = optional(string, "")
    subnet_type = optional(string, "BCC")
    enable_ipv6 = optional(bool, false)
  }))
  description = "Map of public (edge) subnets. Public access typically uses EIP; routing to NAT is optional."
  default     = {}

  validation {
    condition = alltrue([
      for s in var.public_subnets : can(cidrnetmask(s.cidr)) && contains(["BCC", "BCC_NAT", "BBC"], s.subnet_type)
    ])
    error_message = "Each public subnet needs a valid CIDR and subnet_type in [BCC, BCC_NAT, BBC]."
  }
}

variable "private_subnets" {
  type = map(object({
    name        = string
    cidr        = string
    zone_name   = string
    description = optional(string, "")
    subnet_type = optional(string, "BCC")
    enable_ipv6 = optional(bool, false)
  }))
  description = "Map of private subnets. Prefer NAT gateway default route for egress."
  default     = {}

  validation {
    condition = alltrue([
      for s in var.private_subnets : can(cidrnetmask(s.cidr)) && contains(["BCC", "BCC_NAT", "BBC"], s.subnet_type)
    ])
    error_message = "Each private subnet needs a valid CIDR and subnet_type in [BCC, BCC_NAT, BBC]."
  }
}

variable "create_nat_gateway" {
  type        = bool
  description = "Whether to create a NAT gateway for private subnet egress"
  default     = false
}

variable "nat_gateway_name" {
  type        = string
  description = "Name of the NAT gateway"
  default     = "nat-gateway"
}

variable "nat_gateway_spec" {
  type        = string
  description = "NAT gateway specification: small, medium, or large"
  default     = "small"

  validation {
    condition     = contains(["small", "medium", "large"], var.nat_gateway_spec)
    error_message = "nat_gateway_spec must be small, medium, or large."
  }
}

variable "nat_gateway_cu_num" {
  type        = number
  description = "CU number for the NAT gateway (optional; provider-specific)"
  default     = null
}

variable "nat_payment_timing" {
  type        = string
  description = "NAT gateway payment timing: Postpaid or Prepaid"
  default     = "Postpaid"

  validation {
    condition     = contains(["Postpaid", "Prepaid"], var.nat_payment_timing)
    error_message = "nat_payment_timing must be Postpaid or Prepaid."
  }
}

variable "create_nat_eip" {
  type        = bool
  description = "Whether to create an EIP and attach it as SNAT EIP for the NAT gateway"
  default     = true
}

variable "nat_eip_bandwidth_in_mbps" {
  type        = number
  description = "Bandwidth (Mbps) for the NAT SNAT EIP"
  default     = 100
}

variable "nat_eip_billing_method" {
  type        = string
  description = "EIP billing method: ByTraffic or ByBandwidth"
  default     = "ByTraffic"

  validation {
    condition     = contains(["ByTraffic", "ByBandwidth"], var.nat_eip_billing_method)
    error_message = "nat_eip_billing_method must be ByTraffic or ByBandwidth."
  }
}

variable "nat_snat_eips" {
  type        = list(string)
  description = "Existing EIP addresses to use as NAT SNAT EIPs (skips create_nat_eip when non-empty)"
  default     = []
}

variable "enable_private_default_route_to_nat" {
  type        = bool
  description = "Create 0.0.0.0/0 route rules from each private subnet CIDR to the NAT gateway"
  default     = true
}

variable "security_groups" {
  type = map(object({
    name        = string
    description = optional(string, "Managed by Terraform")
    rules = optional(list(object({
      direction       = string
      protocol        = optional(string, "all")
      port_range      = optional(string, "1-65535")
      ether_type      = optional(string, "IPv4")
      source_ip       = optional(string, null)
      dest_ip         = optional(string, null)
      source_group_id = optional(string, null)
      dest_group_id   = optional(string, null)
      remark          = optional(string, "")
    })), [])
  }))
  description = "Map of security groups and rules bound to this VPC"
  default     = {}
}

variable "acl_rules" {
  type = map(object({
    subnet_key             = string
    protocol               = string
    source_ip_address      = string
    destination_ip_address = string
    source_port            = string
    destination_port       = string
    position               = number
    direction              = string
    action                 = string
    description            = optional(string, "")
  }))
  description = "Map of subnet ACL rules. subnet_key must match a public or private subnet key."
  default     = {}
}

variable "additional_route_rules" {
  type = map(object({
    source_address      = string
    destination_address = string
    next_hop_type       = string
    next_hop_id         = string
    description         = optional(string, "")
  }))
  description = "Additional VPC route rules on the default route table"
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
  description = "Additional tags to apply to all resources (BaiduCloud tags are ForceNew on many resources)"
  default     = {}
}
