locals {
  module_tags = merge(
    {
      ManagedBy   = "terraform"
      Module      = "github.com/hanyouqing/terraform-baiducloud-modules/appblb"
      Project     = var.project
      Environment = var.environment
    },
    var.tags
  )
}

resource "baiducloud_appblb" "this" {
  name              = var.name
  description       = var.description
  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  payment_timing    = var.payment_timing
  performance_level = var.performance_level
  security_groups   = length(var.security_groups) > 0 ? var.security_groups : null
  tags              = local.module_tags
}

resource "baiducloud_appblb_server_group" "this" {
  for_each = var.server_groups

  name        = each.value.name
  description = each.value.description != "" ? each.value.description : null
  blb_id      = baiducloud_appblb.this.id
}

resource "baiducloud_appblb_listener" "this" {
  for_each = var.listeners

  blb_id        = baiducloud_appblb.this.id
  listener_port = each.value.listener_port
  protocol      = each.value.protocol
  scheduler     = each.value.scheduler
}
