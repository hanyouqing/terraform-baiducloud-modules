output "signature_ids" {
  description = "Map of SMS signature IDs"
  value       = { for k, v in baiducloud_sms_signature.this : k => v.id }
}

output "template_ids" {
  description = "Map of SMS template IDs"
  value       = { for k, v in baiducloud_sms_template.this : k => v.id }
}

output "signature_statuses" {
  description = "Map of SMS signature review statuses"
  value       = { for k, v in baiducloud_sms_signature.this : k => v.status }
}
