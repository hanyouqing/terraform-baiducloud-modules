output "eip_ids" {
  description = "Map of EIP resource IDs"
  value       = { for k, v in baiducloud_eip.this : k => v.id }
}

output "eip_addresses" {
  description = "Map of EIP public addresses"
  value       = { for k, v in baiducloud_eip.this : k => v.eip }
}

output "eip_statuses" {
  description = "Map of EIP statuses"
  value       = { for k, v in baiducloud_eip.this : k => v.status }
}
