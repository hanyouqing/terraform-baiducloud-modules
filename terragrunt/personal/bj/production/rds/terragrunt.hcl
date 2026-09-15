include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/rds.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  instances = {
    mysql = {
      instance_name    = "prod-mysql"
      engine           = "MySQL"
      engine_version   = "5.7"
      cpu_count        = 4
      memory_capacity  = 8
      volume_capacity  = 200
      disk_io_type     = "cloud_enha"
      payment_timing   = "Postpaid"
      public_access    = false
      vpc_id           = "REPLACE_VPC_ID"
      backup_days      = "7"
      backup_time      = "01:00:00"
      subnets = [
        { subnet_id = "REPLACE_SUBNET_A", zone_name = "cn-bj-a" },
        { subnet_id = "REPLACE_SUBNET_B", zone_name = "cn-bj-b" },
      ]
    }
  }

  readonly_instances = {
    mysql-ro = {
      instance_name       = "prod-mysql-ro"
      source_instance_key = "mysql"
      cpu_count           = 2
      memory_capacity     = 4
      volume_capacity     = 200
      vpc_id              = "REPLACE_VPC_ID"
      subnets = [
        { subnet_id = "REPLACE_SUBNET_B", zone_name = "cn-bj-b" },
      ]
    }
  }

  accounts = {
    app = {
      instance_key = "mysql"
      account_name = "appuser"
      password     = get_env("RDS_APP_PASSWORD", "")
    }
  }

  security_ips = {
    mysql = {
      instance_key = "mysql"
      security_ips = ["10.0.0.0/8"]
    }
  }
}
