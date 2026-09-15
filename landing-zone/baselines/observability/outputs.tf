output "log_store_ids" {
  value = module.bls.log_store_ids
}

output "audit_bucket_names" {
  value = var.create_audit_bucket ? module.bos[0].bucket_names : {}
}
