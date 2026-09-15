locals {
  module_tags = merge(
    {
      ManagedBy   = "terraform"
      Module      = "github.com/hanyouqing/terraform-baiducloud-modules/cds"
      Project     = var.project
      Environment = var.environment
    },
    var.tags
  )

  attachments = {
    for k, v in var.volumes : k => v
    if v.attach_instance_id != null && v.instance_id == null
  }
}

resource "baiducloud_cds" "this" {
  for_each = var.volumes

  name                  = each.value.name != null ? each.value.name : each.key
  description           = each.value.description != "" ? each.value.description : null
  payment_timing        = each.value.payment_timing
  disk_size_in_gb       = each.value.disk_size_in_gb
  storage_type          = each.value.storage_type
  zone_name             = each.value.zone_name
  snapshot_id           = each.value.snapshot_id
  instance_id           = each.value.instance_id
  auto_snapshot         = each.value.auto_snapshot
  manual_snapshot       = each.value.manual_snapshot
  resource_group_id     = each.value.resource_group_id
  reservation_length    = each.value.reservation_length
  reservation_time_unit = each.value.reservation_time_unit
  tags                  = local.module_tags
}

resource "baiducloud_cds_attachment" "this" {
  for_each = local.attachments

  cds_id      = baiducloud_cds.this[each.key].id
  instance_id = each.value.attach_instance_id
}
