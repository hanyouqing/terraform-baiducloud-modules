locals {
  default_checklist = [
    "Console → 消息服务 Kafka: create dedicated cluster (专享版)",
    "Place brokers in private subnets; restrict security groups to app CIDRs",
    "Create topics with replication factor >= 3 for production",
    "Configure consumer groups, ACLs, and SASL if required",
    "Enable BCM monitors (BCE_MQ_KAFKA) + BLS/SMS alert fan-out via monitoring module",
    "Wire producers/consumers from CCE/BCC; keep no public endpoints",
  ]

  checklist = length(var.checklist) > 0 ? var.checklist : local.default_checklist
}
