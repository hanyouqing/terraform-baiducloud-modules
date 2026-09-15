module "appblb" {
  source = "../../"

  name      = "demo-appblb"
  vpc_id    = var.vpc_id
  subnet_id = var.subnet_id

  server_groups = {
    web = {
      name = "web-sg"
    }
  }

  listeners = {
    http = {
      listener_port = 80
      protocol      = "HTTP"
    }
  }

  project     = "demo"
  environment = "development"
}
