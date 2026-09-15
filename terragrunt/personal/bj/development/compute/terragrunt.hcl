include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/compute.hcl"
  expose         = true
  merge_strategy = "deep"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    private_subnet_ids  = { "private-1" = "sbn-mock" }
    security_group_ids  = { "default" = "g-mock" }
  }
}

inputs = {
  instances = {
    app-1 = {
      name              = "dev-app-1"
      image_id          = get_env("TF_VAR_image_id", "REPLACE_ME")
      availability_zone = "cn-bj-a"
      subnet_id         = dependency.vpc.outputs.private_subnet_ids["private-1"]
      instance_spec     = "bcc.g5.c2m8"
      security_groups   = [dependency.vpc.outputs.security_group_ids["default"]]
      keypair_id        = get_env("TF_VAR_keypair_id", null)
    }
  }
}
