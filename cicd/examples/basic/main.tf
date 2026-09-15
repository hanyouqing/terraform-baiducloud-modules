module "cicd" {
  source = "../../"

  deploy_user_name         = "demo-cicd-deploy"
  create_deploy_access_key = true
  create_breakglass_user   = false
  policy_region            = "bj"

  project     = "demo"
  environment = "development"
}
