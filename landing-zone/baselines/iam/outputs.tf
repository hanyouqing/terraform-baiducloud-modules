output "user_names" {
  description = "Baseline IAM user names"
  value       = module.iam.user_names
}

output "access_key_ids" {
  description = "CI/CD access key IDs (secrets are in state / provider outputs)"
  value       = module.iam.access_key_ids
  sensitive   = true
}

output "policy_names" {
  description = "Baseline policy names"
  value       = module.iam.policy_names
}
