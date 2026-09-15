module "iam" {
  source = "../../../iam"

  users = {
    alice = {
      name              = "alice"
      description       = "SSO-mapped sub-user (user federation)"
      create_access_key = false
    }
    bob = {
      name              = "bob"
      description       = "SSO-mapped sub-user"
      create_access_key = false
    }
  }

  policies = {
    readonly = {
      name = "prod-sso-readonly"
      document = jsonencode({
        accessControlList = [{
          region     = "*"
          service    = "bce:*"
          resource   = ["*"]
          permission = ["READ"]
          effect     = "Allow"
        }]
      })
    }
  }

  groups = {
    engineers = {
      name        = "prod-engineers"
      description = "SSO engineers mapped via IdP groups"
      user_keys   = ["alice", "bob"]
      policy_keys = ["readonly"]
    }
  }

  project     = "demo"
  environment = "production"
}

module "saml" {
  source = "../../"

  account_id      = "ACCOUNT_ID"
  federation_mode = "role"

  identity_providers = {
    okta = {
      provider_name   = "okta"
      metadata_source = "https://example.okta.com/app/exk.../sso/saml/metadata"
      description     = "Corporate Okta — role SSO into Landing Zone accounts"
      enabled         = true
    }
    azure = {
      provider_name   = "azure"
      metadata_source = "Azure AD → Enterprise applications → Baidu Cloud → Federation Metadata XML"
      description     = "Partner / B2B IdP"
      enabled         = true
    }
  }

  project     = "demo"
  environment = "production"
  tags = {
    Purpose = "enterprise-sso"
  }
}
