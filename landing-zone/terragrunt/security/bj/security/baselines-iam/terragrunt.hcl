include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../baselines/iam"
}

inputs = {
  account_name            = "security"
  create_cicd_user        = true
  create_breakglass_user  = true
}
