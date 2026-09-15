include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/scs.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  instances = {
    redis = {
      instance_name    = "prod-redis"
      node_type        = "cache.n1.small"
      engine           = "redis"
      engine_version   = "6.0"
      cluster_type     = "master_slave"
      replication_num  = 2
      payment_timing   = "Postpaid"
      client_auth      = get_env("SCS_CLIENT_AUTH", "")
      vpc_id           = "REPLACE_VPC_ID"
      security_groups  = ["REPLACE_SG_ID"]
      backup_days      = "7"
      backup_time      = "02:00:00"
      enable_read_only = 1
      subnets = [
        { subnet_id = "REPLACE_SUBNET_A", zone_name = "cn-bj-a" },
      ]
      replication_info = [
        {
          availability_zone = "cn-bj-a"
          subnet_id         = "REPLACE_SUBNET_A"
          is_master         = true
        },
        {
          availability_zone = "cn-bj-b"
          subnet_id         = "REPLACE_SUBNET_B"
          is_master         = false
        },
      ]
    }
  }
}
