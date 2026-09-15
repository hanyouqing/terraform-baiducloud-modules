output "instance_ids" {
  description = "Map of BEC instance IDs"
  value       = { for k, v in baiducloud_bec_vm_instance.this : k => v.id }
}

output "internal_ips" {
  description = "Map of BEC internal IPs"
  value       = { for k, v in baiducloud_bec_vm_instance.this : k => v.internal_ip }
}

output "public_ips" {
  description = "Map of BEC public IPs"
  value       = { for k, v in baiducloud_bec_vm_instance.this : k => v.public_ip }
}
