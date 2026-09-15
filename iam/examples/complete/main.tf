module "iam" {
  source = "../../"

  users = {
    cicd = {
      name              = "prod-cicd"
      description       = "CI/CD deploy user"
      create_access_key = true
    }
    breakglass = {
      name              = "prod-breakglass"
      description       = "Emergency break-glass"
      create_access_key = false
    }
  }

  policies = {
    deploy = {
      name = "prod-deploy"
      document = jsonencode({
        accessControlList = [{
          region     = "bj"
          service    = "bce:*"
          resource   = ["*"]
          permission = ["READ", "OPERATE"]
          effect     = "Allow"
        }]
      })
    }
  }

  user_policy_attachments = {
    cicd-deploy = {
      user_key   = "cicd"
      policy_key = "deploy"
    }
  }

  groups = {
    operators = {
      name        = "prod-operators"
      description = "Platform operators"
      user_keys   = ["breakglass"]
      policy_keys = ["deploy"]
    }
  }

  project     = "demo"
  environment = "production"
}
