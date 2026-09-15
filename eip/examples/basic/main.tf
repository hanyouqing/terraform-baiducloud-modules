module "eip" {
  source = "../../"

  eips = {
    app = {
      name              = "demo-app-eip"
      bandwidth_in_mbps = 100
      payment_timing    = "Postpaid"
      billing_method    = "ByTraffic"
    }
  }

  project     = "demo"
  environment = "development"
}
