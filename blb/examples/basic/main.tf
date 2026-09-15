module "blb" {
  source = "../../"

  name      = "demo-blb"
  vpc_id    = var.vpc_id
  subnet_id = var.subnet_id

  listeners = {
    http = {
      listener_port    = 80
      backend_port     = 80
      protocol         = "HTTP"
      scheduler        = "RoundRobin"
      health_check_uri = "/"
    }
  }

  backend_servers = [
    for id in var.backend_instance_ids : {
      instance_id = id
      weight      = 100
    }
  ]

  project     = "demo"
  environment = "development"
}
