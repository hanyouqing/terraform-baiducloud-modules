locals {
  module_tags = merge(
    {
      ManagedBy   = "terraform"
      Module      = "github.com/hanyouqing/terraform-baiducloud-modules/dns"
      Project     = var.project
      Environment = var.environment
    },
    var.tags
  )
}

resource "baiducloud_dns_zone" "this" {
  for_each = var.zones

  name = each.value.name
  tags = local.module_tags
}

resource "baiducloud_dns_record" "this" {
  for_each = var.records

  zone_name     = baiducloud_dns_zone.this[each.value.zone_key].name
  rr            = each.value.rr
  type          = each.value.type
  value         = each.value.value
  ttl           = each.value.ttl
  line          = each.value.line
  priority      = each.value.priority
  description   = each.value.description
  record_action = each.value.record_action
}
