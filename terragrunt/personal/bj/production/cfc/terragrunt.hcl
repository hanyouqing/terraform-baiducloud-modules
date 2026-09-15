include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/cfc.hcl"
  expose         = true
  merge_strategy = "deep"
}

# Provide code via local path or BOS before apply.
inputs = {
  functions = {}
}
