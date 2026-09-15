module "bls" {
  source = "../../../bls"

  log_stores = {
    platform = {
      log_store_name = "${var.account_name}-platform"
      retention      = var.log_retention_days
    }
    audit = {
      log_store_name = "${var.account_name}-audit"
      retention      = var.log_retention_days
    }
  }

  project     = var.project
  environment = var.environment
  tags        = merge(var.tags, { Baseline = "observability" })
}

module "bos" {
  count  = var.create_audit_bucket ? 1 : 0
  source = "../../../bos"

  buckets = {
    audit = {
      bucket                      = "${var.project}-${var.account_name}-audit"
      acl                         = "private"
      storage_class               = "STANDARD"
      versioning_status           = "enabled"
      server_side_encryption_rule = "AES256"
    }
  }

  project     = var.project
  environment = var.environment
  tags        = merge(var.tags, { Baseline = "observability" })
}
