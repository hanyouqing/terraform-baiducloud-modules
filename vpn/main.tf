locals {
  module_tags = merge(
    {
      ManagedBy   = "terraform"
      Module      = "github.com/hanyouqing/terraform-baiducloud-modules/vpn"
      Project     = var.project
      Environment = var.environment
    },
    var.tags
  )

  vpn_eip = var.eip != null ? var.eip : (var.create_eip ? baiducloud_eip.this[0].eip : null)
}

resource "baiducloud_eip" "this" {
  count = var.create_eip && var.eip == null ? 1 : 0

  name              = "${var.vpn_name}-eip"
  bandwidth_in_mbps = var.eip_bandwidth_in_mbps
  payment_timing    = "Postpaid"
  billing_method    = "ByTraffic"
  tags              = local.module_tags
}

resource "baiducloud_vpn_gateway" "this" {
  vpn_name       = var.vpn_name
  vpc_id         = var.vpc_id
  description    = var.description
  payment_timing = var.payment_timing
  eip            = local.vpn_eip
}

resource "baiducloud_vpn_conn" "this" {
  for_each = var.connections

  vpn_id         = baiducloud_vpn_gateway.this.id
  vpn_conn_name  = each.value.vpn_conn_name
  secret_key     = each.value.secret_key
  local_subnets  = each.value.local_subnets
  remote_ip      = each.value.remote_ip
  remote_subnets = each.value.remote_subnets
  description    = each.value.description != "" ? each.value.description : null

  dynamic "ike_config" {
    for_each = each.value.ike_config != null ? [each.value.ike_config] : []
    content {
      ike_version   = ike_config.value.ike_version
      ike_mode      = ike_config.value.ike_mode
      ike_enc_alg   = ike_config.value.ike_enc_alg
      ike_auth_alg  = ike_config.value.ike_auth_alg
      ike_pfs       = ike_config.value.ike_pfs
      ike_life_time = ike_config.value.ike_life_time
    }
  }

  dynamic "ipsec_config" {
    for_each = each.value.ipsec_config != null ? [each.value.ipsec_config] : []
    content {
      ipsec_enc_alg   = ipsec_config.value.ipsec_enc_alg
      ipsec_auth_alg  = ipsec_config.value.ipsec_auth_alg
      ipsec_pfs       = ipsec_config.value.ipsec_pfs
      ipsec_life_time = ipsec_config.value.ipsec_life_time
    }
  }
}
