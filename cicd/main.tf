locals {
  default_deploy_document = jsonencode({
    accessControlList = [
      {
        region     = var.policy_region
        service    = "bce:bos"
        resource   = ["*"]
        permission = ["READ", "WRITE"]
        effect     = "Allow"
      },
      {
        region     = var.policy_region
        service    = "bce:bcc"
        resource   = ["*"]
        permission = ["READ", "OPERATE"]
        effect     = "Allow"
      },
      {
        region     = var.policy_region
        service    = "bce:cce"
        resource   = ["*"]
        permission = ["READ", "OPERATE"]
        effect     = "Allow"
      },
      {
        region     = var.policy_region
        service    = "bce:cfc"
        resource   = ["*"]
        permission = ["READ", "WRITE", "OPERATE"]
        effect     = "Allow"
      }
    ]
  })

  deploy_document = var.deploy_policy_document != null ? var.deploy_policy_document : local.default_deploy_document

  users = merge(
    var.create_deploy_user ? {
      deploy = {
        name              = var.deploy_user_name
        description       = var.deploy_user_description
        create_access_key = var.create_deploy_access_key
        force_destroy     = false
      }
    } : {},
    var.create_breakglass_user ? {
      breakglass = {
        name              = var.breakglass_user_name
        description       = var.breakglass_user_description
        create_access_key = false
        force_destroy     = false
      }
    } : {},
    var.extra_users
  )

  policies = merge(
    var.create_deploy_user ? {
      deploy = {
        name        = var.deploy_policy_name
        description = "CI/CD deploy policy"
        document    = local.deploy_document
      }
    } : {},
    var.extra_policies
  )

  attachments = merge(
    var.create_deploy_user ? {
      deploy = {
        user_key   = "deploy"
        policy_key = "deploy"
      }
    } : {},
    var.extra_user_policy_attachments
  )
}

module "iam" {
  source = "../iam"

  users                   = local.users
  policies                = local.policies
  user_policy_attachments = local.attachments
  groups                  = var.groups

  project     = var.project
  environment = var.environment
  tags = merge(var.tags, {
    Purpose = "cicd"
  })
}

module "cfc" {
  source = "../cfc"
  count  = length(var.cfc_functions) > 0 || length(var.cfc_triggers) > 0 ? 1 : 0

  functions = var.cfc_functions
  aliases   = var.cfc_aliases
  triggers  = var.cfc_triggers

  project     = var.project
  environment = var.environment
  tags        = var.tags
}
