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
      instance_name   = "dev-redis"
      node_type       = "cache.n1.micro"
      engine          = "redis"
      engine_version  = "6.0"
      cluster_type    = "master_slave"
      replication_num = 1
      payment_timing  = "Postpaid"
      client_auth     = get_env("SCS_CLIENT_AUTH", "")
      vpc_id          = "REPLACE_VPC_ID"
      subnets = [
        { subnet_id = "REPLACE_SUBNET_ID", zone_name = "cn-bj-a" }
      ]
    }
  }
}
