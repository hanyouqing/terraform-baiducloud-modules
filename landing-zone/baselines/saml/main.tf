module "saml" {
  source = "../../../saml"

  account_id         = var.account_id
  federation_mode    = var.federation_mode
  identity_providers = var.identity_providers

  project     = var.project
  environment = var.environment
  tags = merge(var.tags, {
    LandingZone = "true"
    Account     = var.account_name
    Baseline    = "saml"
  })
}
