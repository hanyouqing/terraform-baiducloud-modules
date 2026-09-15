include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/saml.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  account_id      = "ACCOUNT_ID"
  federation_mode = "role"
  identity_providers = {
    okta = {
      provider_name   = "okta"
      metadata_source = "Okta app metadata URL"
      description     = "Corporate IdP for Landing Zone role SSO"
    }
  }
  tags = {
    Purpose = "enterprise-sso"
  }
}
