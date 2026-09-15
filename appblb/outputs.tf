output "appblb_id" {
  description = "APPBLB ID"
  value       = baiducloud_appblb.this.id
}

output "address" {
  description = "APPBLB private address"
  value       = baiducloud_appblb.this.address
}

output "public_ip" {
  description = "APPBLB public IP if any"
  value       = baiducloud_appblb.this.public_ip
}

output "server_group_ids" {
  description = "Map of server group IDs"
  value       = { for k, v in baiducloud_appblb_server_group.this : k => v.id }
}
