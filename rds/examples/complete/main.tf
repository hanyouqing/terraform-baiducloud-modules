module "rds" {
  source = "../../"

  instances = {
    mysql = {
      instance_name    = "prod-mysql"
      engine           = "MySQL"
      engine_version   = "5.7"
      cpu_count        = 4
      memory_capacity  = 8
      volume_capacity  = 200
      disk_io_type     = "cloud_enha"
      category         = "Standard"
      payment_timing   = "Postpaid"
      public_access    = false
      vpc_id           = var.vpc_id
      backup_days      = "7"
      backup_time      = "01:00:00"
      replication_type = null
      subnets = [
        { subnet_id = var.subnet_id_a, zone_name = var.zone_name_a },
        { subnet_id = var.subnet_id_b, zone_name = var.zone_name_b },
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
      vpc_id              = var.vpc_id
      payment_timing      = "Postpaid"
      subnets = [
        { subnet_id = var.subnet_id_b, zone_name = var.zone_name_b },
      ]
    }
  }

  accounts = {
    app = {
      instance_key = "mysql"
      account_name = "appuser"
      password     = var.db_password
      desc         = "Application account"
    }
  }

  security_ips = {
    mysql = {
      instance_key = "mysql"
      security_ips = [var.app_cidr]
    }
  }

  project     = "demo"
  environment = "production"
  tags = {
    Tier = "data"
  }
}
