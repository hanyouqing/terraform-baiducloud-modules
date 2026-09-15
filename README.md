# Terraform BaiduCloud Modules

Production-ready Terraform modules for [Baidu AI Cloud](https://cloud.baidu.com), modeled after [terraform-oci-modules](https://github.com/hanyouqing/terraform-oci-modules).

Provider: [`baidubce/baiducloud`](https://registry.terraform.io/providers/baidubce/baiducloud/latest) `~> 1.23` · Terraform `>= 1.14.2`

Full capability matrix (what is covered vs provider gaps): [docs/COVERAGE.md](docs/COVERAGE.md)

## Modules

### Networking & security

| Module | Service |
|--------|---------|
| [`vpc`](vpc/) | VPC, subnets, SG, NAT, routes, ACL |
| [`eip`](eip/) | Elastic IP |
| [`vpn`](vpn/) | Site-to-site VPN |
| [`peer-conn`](peer-conn/) | VPC peering |
| [`et-gateway`](et-gateway/) | Express Tunnel / 高速通道 gateway |
| [`blb`](blb/) | Classic load balancer |
| [`appblb`](appblb/) | Application (L7) load balancer |

### Compute & data

| Module | Service |
|--------|---------|
| [`compute`](compute/) | BCC cloud hosts |
| [`bec`](bec/) | BEC edge / lightweight VMs |
| [`cds`](cds/) | Block disks |
| [`bos`](bos/) | Object storage |
| [`cfs`](cfs/) | File storage |
| [`rds`](rds/) | MySQL / SQLServer / PostgreSQL (+ RO / accounts / security IPs) |
| [`scs`](scs/) | Redis / Memcache / PegaDB |
| [`mongodb`](mongodb/) | DocDB replica / sharding |
| [`ccev2`](ccev2/) | Managed Kubernetes |

### CI/CD, observability, messaging / search

| Module | Service |
|--------|---------|
| [`cicd`](cicd/) | Deploy IAM (+ optional CFC); use with GitHub Actions / GitLab |
| [`cfc`](cfc/) | Cloud Function Compute |
| [`monitoring`](monitoring/) | BLS + SMS alert channel + BCM Console checklist |
| [`kafka`](kafka/) | Kafka scaffold (Console — no provider resources) |
| [`search`](search/) | BES / Elasticsearch scaffold (Console — no provider resources) |
| [`iam`](iam/) | Users, keys, policies, groups |
| [`saml`](saml/) | SAML / IAM federation scaffold (Console IdP — no provider resources) |
| [`sms`](sms/) | SMS signatures/templates |
| [`bls`](bls/) | Log stores |
| [`cdn`](cdn/) | CDN domains |
| [`dns`](dns/) | Public DNS zones/records |
| [`cert`](cert/) | TLS certificates |

### Organization & Landing Zone

| Path | Purpose |
|------|---------|
| [`landing-zone`](landing-zone/) | Multi-account catalog, IAM/tag/observability baselines, Terragrunt account topology |

> Baidu **企业组织 / OU / SCP / 云 SSO / SAML IdP** are not in the Terraform provider yet — create them in Console (use [`saml`](saml/) checklists), then apply `landing-zone` IaC baselines per account. Details: [docs/COVERAGE.md](docs/COVERAGE.md).

## Examples: basic vs complete

Each focused module under CI/data/observability ships **two** examples:

| Example | Intent |
|---------|--------|
| `examples/basic` | Minimal usable stack (dev / smoke) |
| `examples/complete` | Enterprise production shape (HA, backups, least privilege, checklists) |

Terragrunt mirrors this as `terragrunt/personal/bj/development/*` (basic) and `.../production/*` (complete).

## Quick start

```bash
cp .env.sh.example .env.sh && source .env.sh
cd vpc/examples/basic && terraform init && terraform plan
make fmt && make validate
```

## Terragrunt

See [terragrunt/README.md](terragrunt/README.md) and [terragrunt/_envcommon/README.md](terragrunt/_envcommon/README.md).

## Provider gaps

BCM alarm *resources*, WAF, bastion (CAG), email delivery, CodeHub, 云效 pipelines, Kafka, and BES have **no** first-class Terraform resources — tracked in [docs/COVERAGE.md](docs/COVERAGE.md). Use `cicd` / `monitoring` / `kafka` / `search` scaffolds where noted.
