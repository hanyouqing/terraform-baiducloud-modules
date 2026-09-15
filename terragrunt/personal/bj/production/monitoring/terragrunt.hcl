include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/monitoring.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  log_stores = {
    app = {
      log_store_name = "prod-app-logs"
      retention      = 90
    }
    audit = {
      log_store_name = "prod-audit-logs"
      retention      = 365
    }
    infra = {
      log_store_name = "prod-infra-logs"
      retention      = 30
    }
  }
}
