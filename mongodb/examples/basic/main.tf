module "mongodb" {
  source = "../../"

  replica_instances = {
    doc = {
      name             = "demo-mongo"
      cpu_count        = 1
      memory_capacity  = 2
      storage          = 20
      payment_timing   = "Postpaid"
      account_password = var.account_password
      vpc_id           = var.vpc_id
      subnets = [
        { subnet_id = var.subnet_id, zone_name = var.zone_name }
      ]
    }
  }

  project     = "demo"
  environment = "development"
}
