module "cicd" {
  source = "../../"

  deploy_user_name         = "prod-cicd-deploy"
  create_deploy_access_key = true
  create_breakglass_user   = true
  breakglass_user_name     = "prod-breakglass"
  policy_region            = "bj"

  groups = {
    deployers = {
      name        = "prod-deployers"
      description = "Humans who may assume deploy duties"
      user_keys   = ["breakglass"]
      policy_keys = ["deploy"]
    }
  }

  cfc_functions = {
    nightly = {
      function_name   = "prod-nightly-job"
      description     = "Nightly automation via CFC"
      handler         = "index.handler"
      runtime         = "nodejs18"
      time_out        = 120
      memory_size     = 256
      code_file_dir   = "${path.module}/src"
      publish_version = true
    }
  }

  cfc_triggers = {
    nightly = {
      function_key        = "nightly"
      source_type         = "crontab"
      name                = "nightly"
      schedule_expression = "cron(0 16 * * ?)"
      enabled             = "Enabled"
    }
  }

  project     = "demo"
  environment = "production"
  tags = {
    Purpose = "cicd"
  }
}
