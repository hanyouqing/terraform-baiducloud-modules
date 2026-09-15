include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../../baselines/saml"
}

inputs = {
  account_name    = "security"
  account_id      = "ACCOUNT_ID"
  federation_mode = "role"
  identity_providers = {
    okta = {
      provider_name   = "okta"
      metadata_source = "Okta metadata URL"
      description     = "Org-wide IdP for role SSO"
    }
  }
}
