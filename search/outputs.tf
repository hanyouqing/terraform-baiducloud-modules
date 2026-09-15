output "provider_gap" {
  description = "BES / Elasticsearch is not available in baiducloud Terraform provider"
  value       = "No baiducloud_bes_* / elasticsearch resources in baidubce/baiducloud ~> 1.23"
}

output "cluster_name" {
  description = "Intended BES cluster name for Console/OpenAPI"
  value       = var.cluster_name
}

output "console_checklist" {
  description = "Production BES setup checklist (Console / OpenAPI)"
  value       = local.checklist
}

output "recommended_tags" {
  description = "Tags to apply when creating BES in Console"
  value = merge(var.tags, {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "console-until-provider"
    Module      = "search"
  })
}

output "alternative" {
  description = "Terraform-supported document alternative"
  value       = "Use ../mongodb for DocDB when Elasticsearch is not mandatory"
}
