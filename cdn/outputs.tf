output "domain_ids" {
  description = "Map of CDN domain resource IDs"
  value       = { for k, v in baiducloud_cdn_domain.this : k => v.id }
}

output "cnames" {
  description = "Map of CDN CNAMEs (point DNS to these)"
  value       = { for k, v in baiducloud_cdn_domain.this : k => v.cname }
}

output "statuses" {
  description = "Map of CDN domain statuses"
  value       = { for k, v in baiducloud_cdn_domain.this : k => v.status }
}
