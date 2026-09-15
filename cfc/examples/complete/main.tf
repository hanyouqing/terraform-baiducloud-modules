module "cfc" {
  source = "../../"

  functions = {
    worker = {
      function_name       = "prod-worker"
      description         = "VPC-attached scheduled worker"
      handler             = "index.handler"
      runtime             = "nodejs18"
      time_out            = 60
      memory_size         = 256
      code_file_dir       = "${path.module}/src"
      publish_version     = true
      version_description = "production"
      environment = {
        APP_ENV = "production"
      }
      vpc_config = {
        vpc_id             = var.vpc_id
        subnet_ids         = var.subnet_ids
        security_group_ids = var.security_group_ids
      }
    }
  }

  aliases = {
    live = {
      alias_name       = "live"
      function_key     = "worker"
      function_version = "published"
      description      = "Stable production alias"
    }
  }

  triggers = {
    hourly = {
      function_key        = "worker"
      source_type         = "crontab"
      name                = "hourly"
      schedule_expression = "cron(0 * * * ?)"
      enabled             = "Enabled"
    }
  }

  project     = "demo"
  environment = "production"
}
