locals {
  module_tags = merge(
    {
      ManagedBy   = "terraform"
      Module      = "github.com/hanyouqing/terraform-baiducloud-modules/cdn"
      Project     = var.project
      Environment = var.environment
    },
    var.tags
  )
}

resource "baiducloud_cdn_domain" "this" {
  for_each = var.domains

  domain       = each.value.domain
  form         = each.value.form
  default_host = each.value.default_host
  tags         = local.module_tags

  dynamic "origin" {
    for_each = each.value.origins
    content {
      addr              = origin.value.addr
      type              = origin.value.type
      backup            = origin.value.backup
      host              = origin.value.host
      weight            = origin.value.weight
      isp               = origin.value.isp
      http_port         = origin.value.http_port
      https_port        = origin.value.https_port
      upstream_protocol = origin.value.upstream_protocol
    }
  }
}
