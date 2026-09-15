# Landing-zone root — account/region/env hierarchy under landing-zone/terragrunt/

locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  env_vars     = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  account_name = local.account_vars.locals.account_name
  account_type = try(local.account_vars.locals.account_type, "workload")
  account_id   = try(local.account_vars.locals.account_id, "REPLACE_ME")
  organization = try(local.account_vars.locals.organization, "example-corp")
  region       = local.region_vars.locals.region
  env          = local.env_vars.locals.environment
  project      = local.env_vars.locals.project

  state_bucket = "${local.project}-${local.account_name}-tfstate"
  bos_endpoint = get_env("BAIDUCLOUD_BOS_ENDPOINT", "https://s3.${local.region}.bcebos.com")
}

remote_state {
  backend = "s3"
  disable_dependency_optimization = true
  config = {
    bucket                      = local.state_bucket
    key                         = "${local.region}/${local.env}/${path_relative_to_include()}/terraform.tfstate"
    region                      = local.region
    endpoint                    = local.bos_endpoint
    encrypt                     = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    force_path_style            = true
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "provider_tg.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOT
    provider "baiducloud" {
      region = "${local.region}"
    }
  EOT
}

inputs = {
  project      = local.project
  environment  = local.env
  account_name = local.account_name
  tags = {
    Organization = local.organization
    Account      = local.account_name
    AccountId    = local.account_id
    AccountType  = local.account_type
    Environment  = local.env
    Project      = local.project
    Region       = local.region
    ManagedBy    = "terraform"
    LandingZone  = "true"
  }
}
