output "et_gateway_ids" {
  description = "Map of ET gateway IDs"
  value       = { for k, v in baiducloud_et_gateway.this : k => v.et_gateway_id }
}

output "statuses" {
  description = "Map of ET gateway statuses"
  value       = { for k, v in baiducloud_et_gateway.this : k => v.status }
}
