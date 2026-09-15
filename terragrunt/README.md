# Terragrunt Layout

Hierarchy:

```text
terragrunt/
  root.hcl
  _envcommon/          # shared module defaults
  personal/            # sample account
    account.hcl
    bj/                # region
      region.hcl
      development/     # basic stacks (smoke / non-prod)
        env.hcl
        vpc/ compute/ bos/ rds/ scs/ mongodb/ cicd/ monitoring/ kafka/ search/ …
      production/      # complete stacks (enterprise shape)
        env.hcl
        vpc/ rds/ scs/ mongodb/ cicd/ monitoring/ kafka/ search/ …
```

`development` ≈ module `examples/basic`; `production` ≈ `examples/complete`.
Replace `REPLACE_*` IDs after VPC apply. Secrets via env (`RDS_APP_PASSWORD`, `SCS_CLIENT_AUTH`, `MONGODB_PASSWORD`).

## Prerequisites

1. Export credentials:
   ```bash
   source .env.sh
   ```
2. Create the remote-state BOS bucket once (`<project>-tfstate`).
3. Install [Terragrunt](https://terragrunt.gruntwork.io/).

## Apply a stack

```bash
cd terragrunt/personal/bj/development/vpc
terragrunt init
terragrunt plan
terragrunt apply
```

Dependencies (e.g. compute → vpc) use Terragrunt `dependency` blocks.
