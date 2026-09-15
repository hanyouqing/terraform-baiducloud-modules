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
  federation_mode = "both"
  identity_providers = {
    azure = {
      provider_name   = "azure"
      metadata_source = "Azure AD metadata XML"
    }
  }
}
