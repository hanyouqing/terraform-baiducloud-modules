include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../baselines/observability"
}

inputs = {
  account_name         = "workload-dev"
  log_retention_days   = 90
  create_audit_bucket  = true
}
