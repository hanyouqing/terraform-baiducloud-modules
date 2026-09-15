# Business system coverage matrix

Maps a typical production stack to modules in this repo and to
`baidubce/baiducloud` provider resources (`~> 1.23`).

| Capability (业务能力) | Module | Provider resources | Status |
|---|---|---|---|
| VPC / 子网 / 路由 / ACL / NAT | [`vpc`](../vpc/) | `vpc`, `subnet`, `route_rule`, `acl`, `nat_gateway` | Covered |
| 安全组 | [`vpc`](../vpc/) (embedded) | `security_group`, `security_group_rule` | Covered |
| 云主机 BCC | [`compute`](../compute/) | `instance`, `eip`, `eip_association` | Covered |
| 轻量 / 边缘计算 | [`bec`](../bec/) | `bec_vm_instance` | Covered (BEC; no dedicated “轻量应用服务器” resource in provider) |
| 块存储 / 对象存储 / 文件存储 | [`cds`](../cds/), [`bos`](../bos/), [`cfs`](../cfs/) | `cds`, `bos_bucket`, `cfs` | Covered |
| EIP | [`eip`](../eip/) | `eip`, `eip_association` | Covered |
| 经典负载均衡 | [`blb`](../blb/) | `blb`, `blb_listener`, `blb_backend_server` | Covered |
| 应用型负载均衡 | [`appblb`](../appblb/) | `appblb`, `appblb_listener`, `appblb_server_group` | Covered |
| VPN | [`vpn`](../vpn/) | `vpn_gateway`, `vpn_conn` | Covered |
| VPC 对等连接 | [`peer-conn`](../peer-conn/) | `peer_conn` | Covered |
| 高速通道 / 专线接入网关 | [`et-gateway`](../et-gateway/) | `et_gateway` | Covered |
| CDN | [`cdn`](../cdn/) | `cdn_domain` | Covered |
| DNS | [`dns`](../dns/) | `dns_zone`, `dns_record` | Covered |
| Kubernetes | [`ccev2`](../ccev2/) | `ccev2_cluster` | Covered |
| 日志 | [`bls`](../bls/) | `bls_log_store` | Covered |
| TLS 证书 | [`cert`](../cert/) | `cert` | Covered |
| IAM | [`iam`](../iam/) | `iam_user`, `iam_access_key`, `iam_policy`, `iam_group`, … | Covered |
| SAML / SSO 联邦 | [`saml`](../saml/) | *(none — Console IdP / roles)* | Scaffold + checklists; pair with `iam` sub-users for user SSO |
| CI/CD 身份 / 自动化 | [`cicd`](../cicd/), [`cfc`](../cfc/) | IAM + `cfc_function` / trigger | Covered (external CI + CFC; no 云效 pipeline resource) |
| 短信通知 / 告警通道 | [`sms`](../sms/) | `sms_signature`, `sms_template` | Covered (SMS only) |
| 性能监控 / 告警 | [`monitoring`](../monitoring/) | BLS + SMS + checklist | Partial — **no `bcm_*` resources**; Console for BCM policies |
| RDS | [`rds`](../rds/) | `rds_instance`, `rds_readonly_instance`, `rds_account`, `rds_security_ip` | Covered |
| Redis / Memcache | [`scs`](../scs/) | `scs` | Covered |
| MongoDB / DocDB | [`mongodb`](../mongodb/) | `mongodb_instance`, `mongodb_sharding_instance` | Covered |
| Search / BES | [`search`](../search/) | *(none)* | Scaffold checklist only |
| Kafka / 消息队列 | [`kafka`](../kafka/) | *(none)* | Scaffold checklist only |
| 组织 / 多账号 / Landing Zone | [`landing-zone`](../landing-zone/) | *(no org/OU/SCP resources)* | Scaffold + baselines |

## Examples & Terragrunt (basic vs complete)

| Area | basic | complete |
|------|-------|----------|
| Module examples | `*/examples/basic` | `*/examples/complete` |
| Terragrunt | `terragrunt/personal/bj/development/{rds,scs,mongodb,cicd,monitoring,kafka,search,…}` | `terragrunt/personal/bj/production/…` |

## Organization / multi-account / Landing Zone

See [`landing-zone/README.md`](../landing-zone/README.md).

## Not available in current Terraform provider

| Capability | Baidu product (typical) | Notes |
|---|---|---|
| 企业组织 / 子账号 / OU / SCP | 企业组织、云治理中心 | `landing-zone/` + Console |
| 云 SSO / SAML IdP / IAM Role | 云 SSO、IAM 用户联合、IAM 角色 SSO | [`saml`](../saml/) checklist + Console; no `iam_saml_provider` / `iam_role` resources |
| 资源组创建 | 资源管理 | Pass existing `resource_group_id` |
| 配置审计 | 配置审计 | Console |
| BCM 监控指标 / 告警策略资源 | 云监控 BCM | Use [`monitoring`](../monitoring/) checklist + Console |
| Kafka | 消息服务 Kafka | [`kafka`](../kafka/) checklist |
| Elasticsearch BES | BES | [`search`](../search/) checklist; DocDB via [`mongodb`](../mongodb/) |
| 堡垒机 | CAG | Console |
| WAF | Web 应用防火墙 | Console |
| 邮件服务 | 邮件推送 | SMS module or third-party |
| 代码仓库 | CodeHub / Git | External VCS |
| CI/CD 流水线 | 云效 / CIC | [`cicd`](../cicd/) + GitHub Actions/GitLab |

## Recommended deploy order

### Single account
1. `cicd` / `iam` → `vpc` → `eip`/`vpn`/`et-gateway`/`peer-conn`
2. `compute` / `bec` / `monitoring` / `bos` / `cds` / `cfs`
3. `blb` / `appblb` / `cert` / `cdn` / `dns`
4. `rds` / `scs` / `mongodb` → `ccev2` / `cfc`
5. Console: Kafka / BES / BCM alarms (use scaffolds)

### Multi-account Landing Zone
1. Console: 企业组织 → OU → member accounts → SCP
2. `landing-zone` catalog + per-account baselines
3. `shared` networking → workload accounts → peer / ET
