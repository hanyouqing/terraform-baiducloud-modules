module "bos" {
  source = "../../"

  buckets = {
    app = {
      bucket                      = var.bucket_name
      acl                         = "private"
      storage_class               = "STANDARD"
      versioning_status           = "enabled"
      server_side_encryption_rule = "AES256"
    }
  }

  project     = "demo"
  environment = "development"
}
