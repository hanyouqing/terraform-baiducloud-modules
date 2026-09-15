output "log_store_ids" {
  description = "Map of BLS log store IDs"
  value       = { for k, v in baiducloud_bls_log_store.this : k => v.id }
}

output "log_store_names" {
  description = "Map of BLS log store names"
  value       = { for k, v in baiducloud_bls_log_store.this : k => v.log_store_name }
}
