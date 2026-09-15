output "cert_ids" {
  description = "Map of certificate IDs"
  value       = { for k, v in baiducloud_cert.this : k => v.id }
}

output "common_names" {
  description = "Map of certificate common names"
  value       = { for k, v in baiducloud_cert.this : k => v.cert_common_name }
}
