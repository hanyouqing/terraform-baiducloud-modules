output "log_store_names" {
  description = "BLS log store names"
  value       = module.bls.log_store_names
}

output "sms_template_ids" {
  description = "SMS template IDs when configured"
  value       = try(module.sms[0].template_ids, {})
}

output "sms_signature_ids" {
  description = "SMS signature IDs when configured"
  value       = try(module.sms[0].signature_ids, {})
}

output "bcm_console_checklist" {
  description = "BCM (performance monitoring / alarms) must be configured in Console — provider has no bcm_* resources"
  value       = local.bcm_checklist
}

output "provider_gap" {
  description = "Short note about BCM gap"
  value       = "baidubce/baiducloud has no BCM monitor/alarm resources as of 1.23.x"
}
