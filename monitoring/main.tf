locals {
  default_bcm_checklist = [
    "Console → 云监控 BCM: enable product monitors for BCC/RDS/SCS/BLB/CCE/BOS",
    "Create alarm policies for CPU / memory / disk / connection / 5xx",
    "Route notifications to SMS (this module templates) and/or webhook / email",
    "Enable custom metrics dashboards for business SLIs",
    "Wire BLS log stores (this module) as investigation backends",
  ]

  bcm_checklist = length(var.bcm_checklist) > 0 ? var.bcm_checklist : local.default_bcm_checklist
}

module "bls" {
  source = "../bls"

  log_stores  = var.log_stores
  project     = var.project
  environment = var.environment
  tags = merge(var.tags, {
    Purpose = "monitoring"
  })
}

module "sms" {
  source = "../sms"
  count  = length(var.sms_signatures) > 0 || length(var.sms_templates) > 0 ? 1 : 0

  signatures  = var.sms_signatures
  templates   = var.sms_templates
  project     = var.project
  environment = var.environment
  tags        = var.tags
}
