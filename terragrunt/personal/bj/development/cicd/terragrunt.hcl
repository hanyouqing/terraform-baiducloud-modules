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
  deploy_user_name         = "dev-cicd-deploy"
  create_deploy_access_key = true
  create_breakglass_user   = false
  policy_region            = "bj"
}
