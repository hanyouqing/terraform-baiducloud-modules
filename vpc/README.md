# BaiduCloud VPC Module

Enterprise VPC foundation: VPC, multi-AZ subnets, security groups, optional NAT + SNAT EIP, route rules, and subnet ACLs.

## Features

- Public / private subnet maps with zone placement
- Optional NAT gateway with managed SNAT EIP
- Private default routes (`0.0.0.0/0` → NAT)
- Security groups + rules bound to the VPC
- Optional subnet ACL rules

## Usage

```hcl
module "vpc" {
  source = "github.com/hanyouqing/terraform-baiducloud-modules//vpc?ref=v0.1.0"

  name = "prod-vpc"
  cidr = "10.0.0.0/16"

  create_nat_gateway = true

  public_subnets = {
    public-a = {
      name      = "prod-public-a"
      cidr      = "10.0.1.0/24"
      zone_name = "cn-bj-a"
    }
  }

  private_subnets = {
    private-a = {
      name      = "prod-private-a"
      cidr      = "10.0.11.0/24"
      zone_name = "cn-bj-a"
    }
  }

  security_groups = {
    default = {
      name = "prod-default-sg"
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
          remark    = "Allow all egress"
        }
      ]
    }
  }

  project     = "myapp"
  environment = "production"
}
```

## Examples

- [`examples/basic`](examples/basic) — public subnet only
- [`examples/complete`](examples/complete) — public + private + NAT + SG

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.14.2 |
| baidubce/baiducloud | ~> 1.23 |
