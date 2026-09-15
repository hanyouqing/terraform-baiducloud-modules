include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/rds.hcl"
  expose         = true
  merge_strategy = "deep"
}

# Fill vpc_id / subnet after vpc apply (dependency optional).
inputs = {
  instances = {
    mysql = {
      instance_name   = "dev-mysql"
      engine          = "MySQL"
      engine_version  = "5.7"
      cpu_count       = 1
      memory_capacity = 2
      volume_capacity = 50
      disk_io_type    = "cloud_high"
      payment_timing  = "Postpaid"
      public_access   = false
      vpc_id          = "REPLACE_VPC_ID"
      subnets = [
        { subnet_id = "REPLACE_SUBNET_ID", zone_name = "cn-bj-a" }
      ]
    }
  }
}
