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
      log_store_name = "dev-app-logs"
      retention      = 7
    }
  }
}
