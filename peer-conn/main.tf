resource "baiducloud_peer_conn" "this" {
  for_each = var.connections

  bandwidth_in_mbps = each.value.bandwidth_in_mbps
  local_vpc_id      = each.value.local_vpc_id
  peer_vpc_id       = each.value.peer_vpc_id
  peer_region       = each.value.peer_region
  description       = each.value.description != "" ? each.value.description : null
  dns_sync          = each.value.dns_sync
  local_if_name     = each.value.local_if_name
  peer_if_name      = each.value.peer_if_name
  peer_account_id   = each.value.peer_account_id

  billing = merge(
    {
      payment_timing = each.value.payment_timing
    },
    each.value.reservation != null ? { reservation = each.value.reservation } : {}
  )
}
