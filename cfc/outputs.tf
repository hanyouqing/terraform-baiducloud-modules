output "function_names" {
  description = "Map of CFC function names"
  value       = { for k, v in baiducloud_cfc_function.this : k => v.function_name }
}

output "function_brns" {
  description = "Map of CFC function BRNs"
  value       = { for k, v in baiducloud_cfc_function.this : k => v.function_brn }
}

output "function_arns" {
  description = "Map of CFC function ARNs"
  value       = { for k, v in baiducloud_cfc_function.this : k => v.function_arn }
}

output "published_versions" {
  description = "Map of published CFC versions"
  value       = { for k, v in baiducloud_cfc_version.this : k => v.version }
}

output "alias_brns" {
  description = "Map of CFC alias BRNs"
  value       = { for k, v in baiducloud_cfc_alias.this : k => v.alias_brn }
}

output "trigger_ids" {
  description = "Map of CFC trigger IDs"
  value       = { for k, v in baiducloud_cfc_trigger.this : k => v.id }
}
