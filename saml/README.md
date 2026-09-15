# BaiduCloud SAML / SSO Module (scaffold)

Baidu Cloud supports **SAML 2.0** federation (IAM 用户联合 / IAM 角色 SSO), but
`baidubce/baiducloud` has **no** Terraform resources for:

- SAML identity providers (IdP metadata upload)
- IAM roles / role trust policies for role SSO
- 云 SSO / Cloud SSO console objects

This module keeps Terragrunt inventories + Console runbooks consistent until
upstream support lands.

## What you do in Terraform

1. Create IAM **sub-users / groups / policies** with [`../iam`](../iam/) (required for **user SSO**).
2. Apply this module to export SP endpoints, IdP attribute templates, and checklists.
3. Configure enterprise IdP (Okta / Azure AD / Keycloak / …) using the outputs.

## Federation modes

| Mode | Baidu Console | Typical use |
|------|---------------|-------------|
| `user` | IAM 用户联合 | 1:1 enterprise user → IAM sub-user |
| `role` | IAM 角色 SSO | Multi-account Landing Zone (preferred) |
| `both` | both | Hybrid |

Official overview: [Federated Login](https://intl.cloud.baidu.com/en/doc/IAM/s/vk2rbiar9-intl-en).

## Examples

- `examples/basic` — single IdP inventory + dual checklists
- `examples/complete` — multi-IdP, role-SSO focused enterprise Landing Zone shape
