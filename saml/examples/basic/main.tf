module "saml" {
  source = "../../"

  account_id      = "ACCOUNT_ID"
  federation_mode = "both"

  identity_providers = {
    azure = {
      provider_name   = "azure"
      metadata_source = "download from Azure AD Enterprise App"
      description     = "Dev IdP"
    }
  }

  project     = "demo"
  environment = "development"
}
