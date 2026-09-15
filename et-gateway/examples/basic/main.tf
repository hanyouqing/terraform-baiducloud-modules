module "et_gateway" {
  source = "../../"

  gateways = {
    hq = {
      name   = "demo-et-gw"
      vpc_id = var.vpc_id
      speed  = 200
    }
  }

  project     = "demo"
  environment = "development"
}
