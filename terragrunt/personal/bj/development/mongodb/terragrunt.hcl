include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/mongodb.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  replica_instances = {
    doc = {
      name             = "dev-mongo"
      cpu_count        = 1
      memory_capacity  = 2
      storage          = 20
      payment_timing   = "Postpaid"
      account_password = get_env("MONGODB_PASSWORD", "")
      vpc_id           = "REPLACE_VPC_ID"
      subnets = [
        { subnet_id = "REPLACE_SUBNET_ID", zone_name = "cn-bj-a" }
      ]
    }
  }
}
