output "user_names" {
  description = "IAM user names created for CI/CD"
  value       = module.iam.user_names
}

output "access_key_ids" {
  description = "Deploy access key IDs (secrets remain in state)"
  value       = module.iam.access_key_ids
  sensitive   = true
}

output "policy_names" {
  description = "IAM policy names"
  value       = module.iam.policy_names
}

output "group_names" {
  description = "IAM group names"
  value       = module.iam.group_names
}

output "cfc_function_brns" {
  description = "Optional CFC function BRNs"
  value       = try(module.cfc[0].function_brns, {})
}

output "pipeline_note" {
  description = "Reminder that Baidu 云效 / CodeHub pipelines are Console/API-only"
  value       = "Use GitHub Actions/GitLab/Jenkins with the deploy access key. Baidu 云效 pipelines are not in baiducloud provider."
}
