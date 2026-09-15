output "instance_ids" {
  description = "Map of SCS instance IDs"
  value       = { for k, v in baiducloud_scs.this : k => v.instance_id }
}

output "domains" {
  description = "Map of SCS domains"
  value       = { for k, v in baiducloud_scs.this : k => v.domain }
}

output "v_net_ips" {
  description = "Map of SCS private IPs"
  value       = { for k, v in baiducloud_scs.this : k => v.v_net_ip }
}

output "ports" {
  description = "Map of SCS ports"
  value       = { for k, v in baiducloud_scs.this : k => v.port }
}

output "statuses" {
  description = "Map of SCS statuses"
  value       = { for k, v in baiducloud_scs.this : k => v.instance_status }
}

output "capacities" {
  description = "Map of SCS capacities"
  value       = { for k, v in baiducloud_scs.this : k => v.capacity }
}
