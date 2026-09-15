module "monitoring" {
  source = "../../"

  log_stores = {
    app = {
      log_store_name = "demo-app-logs"
      retention      = 7
    }
  }

  project     = "demo"
  environment = "development"
}
