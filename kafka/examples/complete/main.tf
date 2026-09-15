module "kafka" {
  source = "../../"

  cluster_name = "prod-kafka"
  project      = "demo"
  environment  = "production"
  tags = {
    Tier = "messaging"
  }
  checklist = [
    "Create dedicated Kafka cluster in private VPC (专享版)",
    "RF>=3 topics; ACL + SASL for producers/consumers",
    "SG allow only app CIDRs; no public endpoints",
    "BCM BCE_MQ_KAFKA alarms → SMS/webhook",
    "Document topic ownership in runbook",
  ]
}
