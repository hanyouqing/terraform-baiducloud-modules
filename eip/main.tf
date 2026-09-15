locals {
  module_tags = merge(
    {
      ManagedBy   = "terraform"
      Module      = "github.com/hanyouqing/terraform-baiducloud-modules/eip"
      Project     = var.project
      Environment = var.environment
    },
    var.tags
  )
}

resource "baiducloud_eip" "this" {
  for_each = var.eips

  name                  = each.value.name != null ? each.value.name : each.key
  bandwidth_in_mbps     = each.value.bandwidth_in_mbps
  payment_timing        = each.value.payment_timing
  billing_method        = each.value.billing_method
  route_type            = each.value.route_type
  reservation_length    = each.value.reservation_length
  reservation_time_unit = each.value.reservation_time_unit
  auto_renew_time       = each.value.auto_renew_time
  auto_renew_time_unit  = each.value.auto_renew_time_unit
  tags                  = local.module_tags
}

resource "baiducloud_eip_association" "this" {
  for_each = var.associations

  eip           = baiducloud_eip.this[each.value.eip_key].eip
  instance_id   = each.value.instance_id
  instance_type = each.value.instance_type
}
