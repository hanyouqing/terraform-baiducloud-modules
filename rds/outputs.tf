output "instance_ids" {
  description = "Map of RDS primary instance IDs"
  value       = { for k, v in baiducloud_rds_instance.this : k => v.instance_id }
}

output "addresses" {
  description = "Map of RDS primary connection addresses"
  value       = { for k, v in baiducloud_rds_instance.this : k => v.address }
}

output "ports" {
  description = "Map of RDS primary ports"
  value       = { for k, v in baiducloud_rds_instance.this : k => v.port }
}

output "statuses" {
  description = "Map of RDS primary instance statuses"
  value       = { for k, v in baiducloud_rds_instance.this : k => v.instance_status }
}

output "v_net_ips" {
  description = "Map of RDS primary private IPs"
  value       = { for k, v in baiducloud_rds_instance.this : k => v.v_net_ip }
}

output "readonly_instance_ids" {
  description = "Map of RDS read-replica instance IDs"
  value       = { for k, v in baiducloud_rds_readonly_instance.this : k => v.instance_id }
}

output "readonly_addresses" {
  description = "Map of RDS read-replica addresses"
  value       = { for k, v in baiducloud_rds_readonly_instance.this : k => v.address }
}

output "account_names" {
  description = "Map of created RDS account names"
  value       = { for k, v in baiducloud_rds_account.this : k => v.account_name }
}

output "security_ip_ids" {
  description = "Map of RDS security IP resource IDs"
  value       = { for k, v in baiducloud_rds_security_ip.this : k => v.id }
}
