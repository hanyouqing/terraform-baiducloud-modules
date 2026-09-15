locals {
  default_checklist = [
    "Console → Elasticsearch BES: create cluster in private VPC",
    "Choose node specs / shard count for production workload",
    "Restrict security group / whitelist to app subnets only",
    "Enable snapshots / index lifecycle policies",
    "Enable BCM monitors (BCE_BES) and route alarms via monitoring module",
    "Prefer HTTPS endpoints; store credentials in secret store",
  ]

  checklist = length(var.checklist) > 0 ? var.checklist : local.default_checklist
}
