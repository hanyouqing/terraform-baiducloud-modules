module "sms" {
  source = "../../"

  signatures = {
    brand = {
      content      = "DemoBrand"
      content_type = "Enterprise"
      country_type = "DOMESTIC"
      description  = "demo signature"
    }
  }

  templates = {
    alert = {
      name         = "demo-alert"
      content      = "Alert: $${content}"
      sms_type     = "CommonNotice"
      country_type = "DOMESTIC"
      description  = "alert template"
    }
  }

  project     = "demo"
  environment = "development"
}
