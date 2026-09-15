variable "cluster_name" {
  type        = string
  description = "CCEv2 cluster name"
}

variable "vpc_id" {
  type = string
}

variable "k8s_version" {
  type        = string
  description = "Kubernetes version"
  default     = "1.30.1"
}

variable "runtime_type" {
  type    = string
  default = "containerd"
}

variable "cluster_type" {
  type    = string
  default = "normal"
}

variable "plugins" {
  type    = list(string)
  default = ["core-dns", "kube-proxy"]
}

variable "master_type" {
  type    = string
  default = "managed"
}

variable "cluster_ha" {
  type    = number
  default = 2
}

variable "exposed_public" {
  type    = bool
  default = false
}

variable "cluster_blb_vpc_subnet_id" {
  type        = string
  description = "Subnet ID for managed master BLB"
}

variable "master_vpc_subnet_zone" {
  type        = string
  description = "Zone label for managed master, e.g. zoneA"
  default     = "zoneA"
}

variable "container_network_mode" {
  type    = string
  default = "vpc-eni"
}

variable "lb_service_vpc_subnet_id" {
  type = string
}

variable "eni_security_group_id" {
  type = string
}

variable "eni_vpc_subnet_zone_and_ids" {
  type        = list(string)
  description = "List of zone:subnet_id for ENI, e.g. [\"zoneA:sbn-xxx\"]"
}

variable "cluster_ip_service_cidr" {
  type    = string
  default = "10.96.0.0/16"
}

variable "max_pods_per_node" {
  type    = number
  default = 64
}

variable "node_port_range_min" {
  type    = number
  default = 30000
}

variable "node_port_range_max" {
  type    = number
  default = 32767
}

variable "kube_proxy_mode" {
  type    = string
  default = "iptables"
}

variable "delete_resource" {
  type    = bool
  default = true
}

variable "delete_cds_snapshot" {
  type    = bool
  default = true
}

variable "description" {
  type    = string
  default = "Managed by Terraform"
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
