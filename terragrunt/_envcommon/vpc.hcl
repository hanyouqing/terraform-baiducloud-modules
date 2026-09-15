locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env      = local.env_vars.locals.environment
  project  = local.env_vars.locals.project
  zone     = try(local.env_vars.locals.zone_name, "cn-bj-a")
}

terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../vpc"
}

inputs = {
  name = "${local.project}-${local.env}-vpc"
  cidr = "10.0.0.0/16"

  create_nat_gateway = true
  create_nat_eip     = true
  nat_gateway_name   = "${local.project}-${local.env}-nat"
  nat_gateway_spec   = "small"

  public_subnets = {
    public-1 = {
      name      = "${local.project}-${local.env}-public-1"
      cidr      = "10.0.1.0/24"
      zone_name = local.zone
    }
  }

  private_subnets = {
    private-1 = {
      name      = "${local.project}-${local.env}-private-1"
      cidr      = "10.0.11.0/24"
      zone_name = local.zone
    }
  }

  security_groups = {
    default = {
      name = "${local.project}-${local.env}-default-sg"
      rules = [
        {
          direction  = "ingress"
          protocol   = "tcp"
          port_range = "443"
          source_ip  = "0.0.0.0/0"
          remark     = "HTTPS"
        },
        {
          direction = "egress"
          protocol  = "all"
          dest_ip   = "0.0.0.0/0"
          remark    = "egress"
        }
      ]
    }
  }
}
