module "monitoring" {
  source = "../../"

  log_stores = {
    app = {
      log_store_name = "prod-app-logs"
      retention      = 90
    }
    audit = {
      log_store_name = "prod-audit-logs"
      retention      = 365
    }
    infra = {
      log_store_name = "prod-infra-logs"
      retention      = 30
    }
  }

  sms_templates = {
    cpu-alert = {
      name         = "prod-cpu-alert"
      content      = "ALERT $${service} CPU $${value}% on $${instance}"
      sms_type     = "CommonNotice"
      country_type = "DOMESTIC"
      description  = "BCM CPU alarm SMS"
    }
  }

  project     = "demo"
  environment = "production"
  tags = {
    Purpose = "observability"
  }
}
