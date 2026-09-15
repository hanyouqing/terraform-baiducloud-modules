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
      name                    = "prod-mongo"
      cpu_count               = 4
      memory_capacity         = 8
      storage                 = 200
      payment_timing          = "Postpaid"
      account_password        = get_env("MONGODB_PASSWORD", "")
      vpc_id                  = "REPLACE_VPC_ID"
      security_ip             = ["10.0.0.0/8"]
      voting_member_num       = 3
      readonly_node_num       = 1
      auto_backup_enable      = "ON"
      preferred_backup_period = ["Mon", "Wed", "Fri"]
      preferred_backup_time   = "03:00Z-04:00Z"
      subnets = [
        { subnet_id = "REPLACE_SUBNET_A", zone_name = "cn-bj-a" },
        { subnet_id = "REPLACE_SUBNET_B", zone_name = "cn-bj-b" },
      ]
    }
  }
}
