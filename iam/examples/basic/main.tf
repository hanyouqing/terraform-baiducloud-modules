module "iam" {
  source = "../../"

  users = {
    cicd = {
      name              = "demo-cicd"
      description       = "CI/CD service user"
      create_access_key = true
    }
  }

  policies = {
    readonly = {
      name = "demo-readonly"
      document = jsonencode({
        accessControlList = [{
          region     = "bj"
          service    = "bce:bos"
          resource   = ["*"]
          permission = ["READ"]
          effect     = "Allow"
        }]
      })
    }
  }

  user_policy_attachments = {
    cicd-readonly = {
      user_key   = "cicd"
      policy_key = "readonly"
    }
  }

  project     = "demo"
  environment = "development"
}
