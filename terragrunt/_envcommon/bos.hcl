locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env      = local.env_vars.locals.environment
  project  = local.env_vars.locals.project
}

terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../bos"
}

inputs = {
  buckets = {
    app = {
      bucket                      = "${local.project}-${local.env}-app"
      acl                         = "private"
      storage_class               = "STANDARD"
      versioning_status           = "enabled"
      server_side_encryption_rule = "AES256"
    }
  }
}
