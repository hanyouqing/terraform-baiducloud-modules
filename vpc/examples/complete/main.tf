module "vpc" {
  source = "../../"

  name               = "demo-vpc-complete"
  cidr               = "10.20.0.0/16"
  create_nat_gateway = true
  create_nat_eip     = true
  nat_gateway_name   = "demo-nat"
  nat_gateway_spec   = "small"

  public_subnets = {
    public-a = {
      name      = "demo-public-a"
      cidr      = "10.20.1.0/24"
      zone_name = var.zone_name
    }
  }

  private_subnets = {
    private-a = {
      name      = "demo-private-a"
      cidr      = "10.20.11.0/24"
      zone_name = var.zone_name
    }
  }

  security_groups = {
    app = {
      name = "demo-app-sg"
      rules = [
        {
          direction  = "ingress"
          protocol   = "tcp"
          port_range = "22"
          source_ip  = "10.20.0.0/16"
          remark     = "SSH from VPC"
        },
        {
          direction = "egress"
          protocol  = "all"
          dest_ip   = "0.0.0.0/0"
        }
      ]
    }
  }

  project     = "demo"
  environment = "production"
}
