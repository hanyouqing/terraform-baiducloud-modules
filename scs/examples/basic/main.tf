module "scs" {
  source = "../../"

  instances = {
    redis = {
      instance_name   = "demo-redis"
      node_type       = "cache.n1.micro"
      engine          = "redis"
      engine_version  = "6.0"
      cluster_type    = "master_slave"
      replication_num = 1
      shard_num       = 1
      payment_timing  = "Postpaid"
      client_auth     = var.client_auth
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
