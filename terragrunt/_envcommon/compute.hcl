locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env      = local.env_vars.locals.environment
  project  = local.env_vars.locals.project
  zone     = try(local.env_vars.locals.zone_name, "cn-bj-a")
}

terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../compute"
}

inputs = {
  # Leaf stacks must set image_id / subnet_id / security_groups via dependency or overrides.
  instances = {}
}
