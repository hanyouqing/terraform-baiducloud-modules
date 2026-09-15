include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/cicd.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  deploy_user_name         = "prod-cicd-deploy"
  create_deploy_access_key = true
  create_breakglass_user   = true
  breakglass_user_name     = "prod-breakglass"
  policy_region            = "bj"

  groups = {
    deployers = {
      name        = "prod-deployers"
      user_keys   = ["breakglass"]
      policy_keys = ["deploy"]
    }
  }
}
