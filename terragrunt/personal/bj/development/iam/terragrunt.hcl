include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/iam.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  users = {
    cicd = {
      name              = "dev-cicd"
      create_access_key = true
    }
  }
  policies = {}
  user_policy_attachments = {}
  groups                  = {}
}
