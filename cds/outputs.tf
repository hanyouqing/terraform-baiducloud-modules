output "volume_ids" {
  description = "Map of CDS volume IDs"
  value       = { for k, v in baiducloud_cds.this : k => v.id }
}

output "volume_statuses" {
  description = "Map of CDS volume statuses"
  value       = { for k, v in baiducloud_cds.this : k => v.status }
}

output "attachment_devices" {
  description = "Map of attachment device paths"
  value       = { for k, v in baiducloud_cds_attachment.this : k => v.attachment_device }
}
