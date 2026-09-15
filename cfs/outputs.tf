output "file_system_ids" {
  description = "Map of CFS IDs"
  value       = { for k, v in baiducloud_cfs.this : k => v.id }
}

output "file_system_statuses" {
  description = "Map of CFS statuses"
  value       = { for k, v in baiducloud_cfs.this : k => v.status }
}

output "mount_target_ids" {
  description = "Map of mount target IDs"
  value       = { for k, v in baiducloud_cfs_mount_target.this : k => v.id }
}

output "mount_target_domains" {
  description = "Map of mount target domains"
  value       = { for k, v in baiducloud_cfs_mount_target.this : k => v.domain }
}
