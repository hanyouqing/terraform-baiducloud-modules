# BaiduCloud Landing Zone

Multi-account governance scaffold for Baidu AI Cloud **企业组织** + **云治理中心 (Landing Zone)**.

## Important provider limitation

`baidubce/baiducloud` **does not** currently expose Terraform resources for:

- Enterprise Organization / member accounts
- Organizational Units (OU)
- Service Control Policies (SCP)
- Cloud SSO / Landing Zone console objects
- Resource Group CRUD (only `resource_group_id` attributes on some resources)

Those control-plane objects must be created in **Console / OpenAPI**. This directory
provides the **IaC half** of a Landing Zone: account catalog, mandatory tags,
per-account IAM + observability baselines, and Terragrunt multi-account topology.

## Target topology

```text
Management (payer)
├── Security OU
│   └── security account          # audit logs, break-glass
├── Infrastructure OU
│   └── shared account            # shared VPC hub, DNS, CDN, artifacts
└── Workloads OU
    ├── NonProd / workload-dev
    └── Prod / workload-prod
```

## Components

| Path | Purpose |
|------|---------|
| [`accounts/catalog.hcl.example`](accounts/catalog.hcl.example) | Account inventory + OU/SCP checklist |
| [`baselines/tags`](baselines/tags) | Mandatory tag map |
| [`baselines/iam`](baselines/iam) | CI/CD + break-glass users |
| [`baselines/saml`](baselines/saml) | SAML IdP inventory + user/role SSO Console checklists |
| [`baselines/observability`](baselines/observability) | BLS + private audit BOS |
| [`terragrunt/`](terragrunt/) | One directory per account |

## Bootstrap runbook

1. **Console**: enable 企业组织; create OUs; invite/create member accounts; attach SCPs.
2. Copy `accounts/catalog.hcl.example` → `accounts/catalog.hcl` and fill account IDs.
3. Create per-account remote-state BOS buckets: `<project>-<account>-tfstate`.
4. Export each account’s AK/SK and apply baselines:
   ```bash
   cd landing-zone/terragrunt/security/bj/security/baselines-iam
   terragrunt apply
   cd ../baselines-observability && terragrunt apply
   ```
5. Deploy `shared` networking/DNS, then workload accounts.
6. Cross-account connectivity: `peer-conn` / `et-gateway` / `vpn` modules.

## Mapping to Baidu products

| Landing Zone concept | Baidu product | How we implement |
|---|---|---|
| Org / accounts | 企业组织 | Catalog + Console |
| OU tree | 组织单元 | Documented in catalog |
| SCP | 服务控制策略 | Documented checklist |
| Account baseline | 账号基线 | `baselines/*` Terraform |
| Multi-account SSO | 云 SSO / IAM 角色 SSO | [`baselines/saml`](baselines/saml) + Console IdP (prefer role SSO) |
| Config audit | 配置审计 | Console (no TF yet) |
| Resource grouping | 资源组 | Pass `resource_group_id` into modules when known |
