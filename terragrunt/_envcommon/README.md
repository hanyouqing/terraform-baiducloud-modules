Shared Terragrunt defaults included by leaf stacks via `include "envcommon"`.

## Data / CI / observability (basic vs complete)

| Stack | development (basic) | production (complete) |
|-------|---------------------|------------------------|
| `rds` | single MySQL | multi-AZ + RO + accounts + security_ips |
| `scs` | small Redis | multi-AZ replication + SG + backups |
| `mongodb` | small replica | multi-AZ + backup + whitelist |
| `cicd` | deploy user | deploy + breakglass + group |
| `monitoring` | short BLS retention | long retention + SMS templates |
| `kafka` / `search` | Console checklist scaffold | production checklist + tags |

Replace `REPLACE_*` IDs after applying `vpc`.
