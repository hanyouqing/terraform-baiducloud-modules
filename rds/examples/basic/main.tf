module "rds" {
  source = "../../"

  instances = {
    mysql = {
      instance_name   = "demo-mysql"
      engine          = "MySQL"
      engine_version  = "5.7"
      cpu_count       = 1
      memory_capacity = 2
      volume_capacity = 50
      disk_io_type    = "cloud_high"
      payment_timing  = "Postpaid"
      public_access   = false
      vpc_id          = var.vpc_id
      subnets = [
        {
          subnet_id = var.subnet_id
          zone_name = var.zone_name
        }
      ]
    }
  }

  project     = "demo"
  environment = "development"
}
