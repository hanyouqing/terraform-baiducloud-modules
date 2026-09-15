locals {
  module_tags = merge(
    {
      ManagedBy   = "terraform"
      Module      = "github.com/hanyouqing/terraform-baiducloud-modules/vpc"
      Project     = var.project
      Environment = var.environment
    },
    var.tags
  )

  all_subnets = merge(
    { for k, v in var.public_subnets : k => merge(v, { tier = "public" }) },
    { for k, v in var.private_subnets : k => merge(v, { tier = "private" }) }
  )

  nat_snat_eips_effective = length(var.nat_snat_eips) > 0 ? var.nat_snat_eips : (
    var.create_nat_gateway && var.create_nat_eip ? [baiducloud_eip.nat[0].eip] : []
  )

  security_group_rules = {
    for pair in flatten([
      for sg_key, sg in var.security_groups : [
        for idx, rule in sg.rules : {
          key    = "${sg_key}-${idx}"
          sg_key = sg_key
          rule   = rule
        }
      ]
    ]) : pair.key => pair
  }
}

resource "baiducloud_vpc" "this" {
  name         = var.name
  cidr         = var.cidr
  description  = var.description
  enable_ipv6  = var.enable_ipv6
  enable_relay = var.enable_relay

  secondary_cidrs = length(var.secondary_cidrs) > 0 ? var.secondary_cidrs : null
  tags            = local.module_tags
}

resource "baiducloud_subnet" "this" {
  for_each = local.all_subnets

  name        = each.value.name
  cidr        = each.value.cidr
  zone_name   = each.value.zone_name
  vpc_id      = baiducloud_vpc.this.id
  description = each.value.description != "" ? each.value.description : "${each.value.tier} subnet managed by Terraform"
  subnet_type = each.value.subnet_type
  enable_ipv6 = each.value.enable_ipv6
  tags        = merge(local.module_tags, { Tier = each.value.tier })
}

resource "baiducloud_eip" "nat" {
  count = var.create_nat_gateway && var.create_nat_eip && length(var.nat_snat_eips) == 0 ? 1 : 0

  name              = "${var.nat_gateway_name}-snat"
  bandwidth_in_mbps = var.nat_eip_bandwidth_in_mbps
  payment_timing    = "Postpaid"
  billing_method    = var.nat_eip_billing_method
  tags              = local.module_tags
}

resource "baiducloud_nat_gateway" "this" {
  count = var.create_nat_gateway ? 1 : 0

  name   = var.nat_gateway_name
  vpc_id = baiducloud_vpc.this.id
  spec   = var.nat_gateway_spec
  cu_num = var.nat_gateway_cu_num

  snat_eips = length(local.nat_snat_eips_effective) > 0 ? local.nat_snat_eips_effective : null

  billing = {
    payment_timing = var.nat_payment_timing
  }

  lifecycle {
    precondition {
      condition     = !var.create_nat_gateway || length(local.nat_snat_eips_effective) > 0
      error_message = "NAT gateway requires at least one SNAT EIP. Set create_nat_eip=true or provide nat_snat_eips."
    }
  }
}

resource "baiducloud_route_rule" "private_default_nat" {
  for_each = var.create_nat_gateway && var.enable_private_default_route_to_nat ? var.private_subnets : {}

  route_table_id      = baiducloud_vpc.this.route_table_id
  source_address      = each.value.cidr
  destination_address = "0.0.0.0/0"
  next_hop_type       = "nat"
  next_hop_id         = baiducloud_nat_gateway.this[0].id
  description         = "Default route via NAT for ${each.value.name}"
}

resource "baiducloud_route_rule" "additional" {
  for_each = var.additional_route_rules

  route_table_id      = baiducloud_vpc.this.route_table_id
  source_address      = each.value.source_address
  destination_address = each.value.destination_address
  next_hop_type       = each.value.next_hop_type
  next_hop_id         = each.value.next_hop_id
  description         = each.value.description
}

resource "baiducloud_security_group" "this" {
  for_each = var.security_groups

  name        = each.value.name
  description = each.value.description
  vpc_id      = baiducloud_vpc.this.id
  tags        = local.module_tags
}

resource "baiducloud_security_group_rule" "this" {
  for_each = local.security_group_rules

  security_group_id = baiducloud_security_group.this[each.value.sg_key].id
  direction         = each.value.rule.direction
  protocol          = each.value.rule.protocol
  port_range        = each.value.rule.port_range
  ether_type        = each.value.rule.ether_type
  source_ip         = each.value.rule.source_ip
  dest_ip           = each.value.rule.dest_ip
  source_group_id   = each.value.rule.source_group_id
  dest_group_id     = each.value.rule.dest_group_id
  remark            = each.value.rule.remark != "" ? each.value.rule.remark : null
}

resource "baiducloud_acl" "this" {
  for_each = var.acl_rules

  subnet_id              = baiducloud_subnet.this[each.value.subnet_key].id
  protocol               = each.value.protocol
  source_ip_address      = each.value.source_ip_address
  destination_ip_address = each.value.destination_ip_address
  source_port            = each.value.source_port
  destination_port       = each.value.destination_port
  position               = each.value.position
  direction              = each.value.direction
  action                 = each.value.action
  description            = each.value.description != "" ? each.value.description : null
}
