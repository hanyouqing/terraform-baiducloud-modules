resource "baiducloud_et_gateway" "this" {
  for_each = var.gateways

  name        = each.value.name
  vpc_id      = each.value.vpc_id
  speed       = each.value.speed
  description = each.value.description
  et_id       = each.value.et_id
  channel_id  = each.value.channel_id
  local_cidrs = each.value.local_cidrs
}
