locals {
  module_tags = merge(
    {
      ManagedBy   = "terraform"
      Module      = "github.com/hanyouqing/terraform-baiducloud-modules/bos"
      Project     = var.project
      Environment = var.environment
    },
    var.tags
  )
}

resource "baiducloud_bos_bucket" "this" {
  for_each = var.buckets

  bucket                      = each.value.bucket
  acl                         = each.value.acl
  storage_class               = each.value.storage_class
  versioning_status           = each.value.versioning_status
  enable_multi_az             = each.value.enable_multi_az
  force_destroy               = each.value.force_destroy
  server_side_encryption_rule = each.value.server_side_encryption_rule
  resource_group              = each.value.resource_group
  tags                        = local.module_tags

  dynamic "logging" {
    for_each = each.value.logging != null ? [each.value.logging] : []
    content {
      target_bucket = logging.value.target_bucket
      target_prefix = logging.value.target_prefix
    }
  }

  dynamic "website" {
    for_each = each.value.website != null ? [each.value.website] : []
    content {
      index_document = website.value.index_document
      error_document = website.value.error_document
    }
  }

  dynamic "cors_rule" {
    for_each = each.value.cors_rules
    content {
      allowed_origins = cors_rule.value.allowed_origins
      allowed_methods = cors_rule.value.allowed_methods
      allowed_headers = cors_rule.value.allowed_headers
      max_age_seconds = cors_rule.value.max_age_seconds
    }
  }

  dynamic "lifecycle_rule" {
    for_each = each.value.lifecycle_rules
    content {
      id       = lifecycle_rule.value.id
      status   = lifecycle_rule.value.status
      resource = lifecycle_rule.value.resource
      condition {
        time {
          date_greater_than = lifecycle_rule.value.date_greater_than
        }
      }
      action {
        name = lifecycle_rule.value.action_name
      }
    }
  }
}
