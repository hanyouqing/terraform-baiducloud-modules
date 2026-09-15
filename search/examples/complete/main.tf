module "search" {
  source = "../../"

  cluster_name = "prod-bes"
  project      = "demo"
  environment  = "production"
  tags = {
    Tier = "search"
  }
  checklist = [
    "Create BES cluster in private VPC with multi-AZ nodes",
    "Whitelist app subnets only; HTTPS endpoints",
    "Snapshot + ILM policies; retention aligned to compliance",
    "BCM BCE_BES alarms → monitoring/SMS",
    "If ES not required, prefer mongodb module for DocDB",
  ]
}
