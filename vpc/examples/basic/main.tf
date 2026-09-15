module "vpc" {
  source = "../../"

  name        = "demo-vpc-basic"
  cidr        = "10.10.0.0/16"
  description = "Basic VPC example"

  public_subnets = {
    public-a = {
      name      = "demo-public-a"
      cidr      = "10.10.1.0/24"
      zone_name = var.zone_name
    }
  }

  security_groups = {
    web = {
      name        = "demo-web-sg"
      description = "HTTPS only"
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

  project     = "demo"
  environment = "development"
}
