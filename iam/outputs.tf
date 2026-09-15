output "user_names" {
  description = "Map of IAM user names"
  value       = { for k, v in baiducloud_iam_user.this : k => v.name }
}

output "user_unique_ids" {
  description = "Map of IAM user unique IDs"
  value       = { for k, v in baiducloud_iam_user.this : k => v.unique_id }
}

output "policy_names" {
  description = "Map of IAM policy names"
  value       = { for k, v in baiducloud_iam_policy.this : k => v.name }
}

output "access_key_ids" {
  description = "Map of created access key IDs"
  value       = { for k, v in baiducloud_iam_access_key.this : k => v.id }
  sensitive   = true
}

output "group_names" {
  description = "Map of IAM group names"
  value       = { for k, v in baiducloud_iam_group.this : k => v.name }
}
