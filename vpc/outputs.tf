output "vpc_id" {
  description = "ID of the VPC"
  value       = baiducloud_vpc.this.id
}

output "vpc_cidr" {
  description = "Primary CIDR of the VPC"
  value       = baiducloud_vpc.this.cidr
}

output "vpc_name" {
  description = "Name of the VPC"
  value       = baiducloud_vpc.this.name
}

output "route_table_id" {
  description = "Default route table ID of the VPC"
  value       = baiducloud_vpc.this.route_table_id
}

output "subnet_ids" {
  description = "Map of all subnet IDs"
  value       = { for k, v in baiducloud_subnet.this : k => v.id }
}

output "public_subnet_ids" {
  description = "Map of public subnet IDs"
  value       = { for k, v in baiducloud_subnet.this : k => v.id if local.all_subnets[k].tier == "public" }
}

output "private_subnet_ids" {
  description = "Map of private subnet IDs"
  value       = { for k, v in baiducloud_subnet.this : k => v.id if local.all_subnets[k].tier == "private" }
}

output "subnet_cidrs" {
  description = "Map of subnet CIDRs"
  value       = { for k, v in baiducloud_subnet.this : k => v.cidr }
}

output "nat_gateway_id" {
  description = "ID of the NAT gateway"
  value       = var.create_nat_gateway ? baiducloud_nat_gateway.this[0].id : null
}

output "nat_snat_eips" {
  description = "SNAT EIP addresses attached to the NAT gateway"
  value       = var.create_nat_gateway ? local.nat_snat_eips_effective : []
}

output "security_group_ids" {
  description = "Map of security group IDs"
  value       = { for k, v in baiducloud_security_group.this : k => v.id }
}
