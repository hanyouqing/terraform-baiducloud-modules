module "cert" {
  source = "../../"

  certificates = {
    web = {
      cert_name         = "demo-web"
      cert_server_data  = var.cert_server_data
      cert_private_data = var.cert_private_data
    }
  }

  project     = "demo"
  environment = "development"
}
