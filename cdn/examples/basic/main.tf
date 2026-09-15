module "cdn" {
  source = "../../"

  domains = {
    www = {
      domain = "cdn.example.com"
      form   = "image"
      origins = [
        {
          addr   = "1.2.3.4"
          type   = "IP"
          backup = false
          weight = 100
        }
      ]
    }
  }

  project     = "demo"
  environment = "development"
}
