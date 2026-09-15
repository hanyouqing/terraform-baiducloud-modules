output "blb_id" {
  description = "ID of the BLB"
  value       = baiducloud_blb.this.id
}

output "blb_address" {
  description = "Private service IP of the BLB"
  value       = baiducloud_blb.this.address
}

output "blb_public_ip" {
  description = "Public IP of the BLB if any"
  value       = baiducloud_blb.this.public_ip
}

output "blb_status" {
  description = "Status of the BLB"
  value       = baiducloud_blb.this.status
}

output "listener_ids" {
  description = "Map of listener resource IDs"
  value       = { for k, v in baiducloud_blb_listener.this : k => v.id }
}
