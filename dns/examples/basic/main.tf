module "dns" {
  source = "../../"

  zones = {
    example = { name = "example.com" }
  }

  records = {
    www = {
      zone_key = "example"
      rr       = "www"
      type     = "A"
      value    = "1.2.3.4"
      ttl      = 60
    }
  }

  project     = "demo"
  environment = "development"
}
