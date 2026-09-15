module "scs" {
  source = "../../"

  instances = {
    redis = {
      instance_name    = "prod-redis"
      node_type        = "cache.n1.small"
      engine           = "redis"
      engine_version   = "6.0"
      cluster_type     = "master_slave"
      replication_num  = 2
      shard_num        = 1
      payment_timing   = "Postpaid"
      client_auth      = var.client_auth
      vpc_id           = var.vpc_id
      security_groups  = var.security_group_ids
      backup_days      = "7"
      backup_time      = "02:00:00"
      enable_read_only = 1
      subnets = [
        { subnet_id = var.subnet_id_a, zone_name = var.zone_name_a },
      ]
      replication_info = [
        {
          availability_zone = var.zone_name_a
          subnet_id         = var.subnet_id_a
          is_master         = true
        },
        {
          availability_zone = var.zone_name_b
          subnet_id         = var.subnet_id_b
          is_master         = false
        },
      ]
    }
  }

  project     = "demo"
  environment = "production"
  tags = {
    Tier = "cache"
  }
}
