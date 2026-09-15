output "provider_gap" {
  description = "SAML IdP / Cloud SSO are not in baiducloud Terraform provider"
  value       = "No baiducloud_iam_saml_provider / cloud_sso / iam_role resources in baidubce/baiducloud ~> 1.23"
}

output "federation_mode" {
  description = "Selected federation mode"
  value       = var.federation_mode
}

output "service_provider" {
  description = "Baidu Cloud SAML SP endpoints (configure on enterprise IdP)"
  value       = local.sp
}

output "identity_providers" {
  description = "Documented IdP inventory with recommended assertion attribute templates"
  value       = local.identity_providers
}

output "user_sso_checklist" {
  description = "IAM user federation Console checklist"
  value       = var.federation_mode == "role" ? [] : local.user_sso_checklist
}

output "role_sso_checklist" {
  description = "IAM role SSO Console checklist"
  value       = var.federation_mode == "user" ? [] : local.role_sso_checklist
}

output "recommended_tags" {
  description = "Tags to apply when creating IdP/roles in Console"
  value = merge(var.tags, {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "console-until-provider"
    Module      = "saml"
  })
}

output "companion_modules" {
  description = "Terraform companions for SAML landing"
  value = {
    iam_subusers_groups = "../iam"
    cicd_deploy_user    = "../cicd"
    landing_zone        = "../landing-zone"
  }
}
