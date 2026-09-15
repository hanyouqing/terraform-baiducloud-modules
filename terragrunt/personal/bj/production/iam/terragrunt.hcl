include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/iam.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  users = {
    cicd = {
      name              = "prod-cicd"
      create_access_key = true
    }
    breakglass = {
      name              = "prod-breakglass"
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
      user_keys   = ["breakglass"]
      policy_keys = ["deploy"]
    }
  }
}
