locals {
  default_cicd_document = jsonencode({
    accessControlList = [
      {
        region     = "*"
        service    = "bce:bos"
        resource   = ["*"]
        permission = ["READ", "WRITE"]
        effect     = "Allow"
      },
      {
        region     = "*"
        service    = "bce:bcc"
        resource   = ["*"]
        permission = ["READ", "OPERATE"]
        effect     = "Allow"
      }
    ]
  })

  cicd_document = var.cicd_policy_document != null ? var.cicd_policy_document : local.default_cicd_document

  users = merge(
    var.create_cicd_user ? {
      cicd = {
        name              = "${var.account_name}-cicd"
        description       = "Landing Zone CI/CD service user for ${var.account_name}"
        create_access_key = true
        force_destroy     = false
      }
    } : {},
    var.create_breakglass_user ? {
      breakglass = {
        name              = "${var.account_name}-breakglass"
        description       = "Emergency break-glass user for ${var.account_name}"
        create_access_key = false
        force_destroy     = false
      }
    } : {}
  )

  policies = var.create_cicd_user ? {
    cicd = {
      name        = "${var.account_name}-cicd-policy"
      description = "Landing Zone CI/CD baseline policy"
      document    = local.cicd_document
    }
  } : {}

  attachments = var.create_cicd_user ? {
    cicd = {
      user_key   = "cicd"
      policy_key = "cicd"
    }
  } : {}
}

module "iam" {
  source = "../../../iam"

  users                   = local.users
  policies                = local.policies
  user_policy_attachments = local.attachments
  groups                  = {}

  project     = var.project
  environment = var.environment
  tags = merge(var.tags, {
    LandingZone = "true"
    Account     = var.account_name
    Baseline    = "iam"
  })
}
