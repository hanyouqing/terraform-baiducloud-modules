locals {
  required_tags = merge(
    {
      Organization = var.organization
      Account      = var.account_name
      AccountType  = var.account_type
      Environment  = var.environment
      Project      = var.project
      ManagedBy    = "terraform"
      LandingZone  = "true"
    },
    var.cost_center != null ? { CostCenter = var.cost_center } : {},
    var.owner != null ? { Owner = var.owner } : {},
    var.extra_tags
  )
}
