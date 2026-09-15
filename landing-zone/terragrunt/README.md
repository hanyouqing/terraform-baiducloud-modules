# Landing Zone Terragrunt Layout

```text
landing-zone/terragrunt/
  root.hcl
  management/bj/baselines/...
  security/bj/baselines/...
  shared/bj/baselines/...
  workload-dev/bj/development/...
  workload-prod/bj/production/...
```

Each top-level directory is one Baidu Cloud **member account**. Credentials are
selected via `BAIDUCLOUD_ACCESS_KEY` / `SECRET_KEY` for that account (or
AssumeRole when available).

Bootstrap order:

1. Create Enterprise Organization + OUs + member accounts in Console
2. Fill `landing-zone/accounts/catalog.hcl`
3. Apply `baselines/iam` + `baselines/observability` in security/shared/workloads
4. Deploy shared VPC/DNS/CDN in `shared`
5. Deploy workload stacks with dependency on shared outputs
