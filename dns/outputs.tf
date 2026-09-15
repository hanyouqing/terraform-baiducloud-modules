output "zone_ids" {
  description = "Map of DNS zone IDs"
  value       = { for k, v in baiducloud_dns_zone.this : k => v.zone_id }
}

output "zone_names" {
  description = "Map of DNS zone names"
  value       = { for k, v in baiducloud_dns_zone.this : k => v.name }
}

output "record_ids" {
  description = "Map of DNS record IDs"
  value       = { for k, v in baiducloud_dns_record.this : k => v.record_id }
}
