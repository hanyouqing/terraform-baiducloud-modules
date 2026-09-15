module "mongodb" {
  source = "../../"

  replica_instances = {
    doc = {
      name                    = "prod-mongo"
      cpu_count               = 4
      memory_capacity         = 8
      storage                 = 200
      payment_timing          = "Postpaid"
      account_password        = var.account_password
      vpc_id                  = var.vpc_id
      security_ip             = [var.app_cidr]
      voting_member_num       = 3
      readonly_node_num       = 1
      auto_backup_enable      = "ON"
      preferred_backup_period = ["Mon", "Wed", "Fri"]
      preferred_backup_time   = "03:00Z-04:00Z"
      enable_increment_backup = 1
      subnets = [
        { subnet_id = var.subnet_id_a, zone_name = var.zone_name_a },
        { subnet_id = var.subnet_id_b, zone_name = var.zone_name_b },
      ]
    }
  }

  project     = "demo"
  environment = "production"
  tags = {
    Tier = "document"
  }
}
