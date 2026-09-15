module "bls" {
  source = "../../"

  log_stores = {
    app = {
      log_store_name = "demo-app-logs"
      retention      = 30
    }
  }

  project     = "demo"
  environment = "development"
}
