locals {
  sp = {
    recipient = "https://login.bce.baidu.com/saml"
    audience  = "urn:bce:baidu:webservices"
    login_url = "https://login.bce.baidu.com/saml"
  }

  default_user_sso_checklist = [
    "Console → 多用户访问控制 → 外部账号接入 → IAM用户联合",
    "Create identity provider; upload enterprise IdP SAML metadata XML",
    "Enable user federation switch",
    "Pre-create matching IAM sub-users (use ../iam module) for each SSO principal",
    "IdP assertion Audience = urn:bce:baidu:webservices",
    "IdP Recipient / ACS = https://login.bce.baidu.com/saml",
    "IdP attribute https://bce.baidu.com/SAML/Attributes/Subuser = accountId:subuser-name/{name}, accountId:saml-provider/{provider}",
    "Map enterprise groups → IAM groups/policies in this account",
  ]

  default_role_sso_checklist = [
    "Console → 外部账号接入 → IAM角色SSO：create IdP + upload metadata",
    "Create IAM role with external IdP as trusted principal (role carrier)",
    "Attach least-privilege policies to the role",
    "IdP assertion Audience = urn:bce:baidu:webservices",
    "IdP Recipient / ACS = https://login.bce.baidu.com/saml",
    "IdP attribute https://bce.baidu.com/SAML/Attributes/Role = accountId:role/{role}, accountId:saml-provider/{provider}",
    "IdP attribute https://bce.baidu.com/SAML/Attributes/RoleSessionName = session display name",
    "Prefer role SSO for multi-account Landing Zone (one IdP → many accounts)",
  ]

  user_sso_checklist = length(var.user_sso_checklist) > 0 ? var.user_sso_checklist : local.default_user_sso_checklist
  role_sso_checklist = length(var.role_sso_checklist) > 0 ? var.role_sso_checklist : local.default_role_sso_checklist

  identity_providers = {
    for k, v in var.identity_providers : k => merge(v, {
      recommended_subuser_attribute = format(
        "%s:subuser-name/{subuser_name}, %s:saml-provider/%s",
        coalesce(v.account_id, var.account_id, "ACCOUNT_ID"),
        coalesce(v.account_id, var.account_id, "ACCOUNT_ID"),
        v.provider_name
      )
      recommended_role_attribute = format(
        "%s:role/{role_name}, %s:saml-provider/%s",
        coalesce(v.account_id, var.account_id, "ACCOUNT_ID"),
        coalesce(v.account_id, var.account_id, "ACCOUNT_ID"),
        v.provider_name
      )
    })
  }
}
