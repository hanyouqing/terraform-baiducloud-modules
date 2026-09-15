output "provider_gap" {
  description = "Kafka is not available in baiducloud Terraform provider"
  value       = "No baiducloud_kafka_* resources in baidubce/baiducloud ~> 1.23"
}

output "cluster_name" {
  description = "Intended cluster name for Console/OpenAPI"
  value       = var.cluster_name
}

output "console_checklist" {
  description = "Production Kafka setup checklist (Console / OpenAPI)"
  value       = local.checklist
}

output "recommended_tags" {
  description = "Tags to apply when creating Kafka in Console"
  value = merge(var.tags, {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "console-until-provider"
    Module      = "kafka"
  })
}
