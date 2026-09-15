locals {
  module_tags = merge(
    {
      ManagedBy   = "terraform"
      Module      = "github.com/hanyouqing/terraform-baiducloud-modules/blb"
      Project     = var.project
      Environment = var.environment
    },
    var.tags
  )
}

resource "baiducloud_blb" "this" {
  name              = var.name
  description       = var.description
  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  payment_timing    = var.payment_timing
  performance_level = var.performance_level
  security_groups   = length(var.security_groups) > 0 ? var.security_groups : null
  allocate_ipv6     = var.allocate_ipv6
  allow_delete      = var.allow_delete
  tags              = local.module_tags
}

resource "baiducloud_blb_listener" "this" {
  for_each = var.listeners

  blb_id                         = baiducloud_blb.this.id
  listener_port                  = each.value.listener_port
  backend_port                   = each.value.backend_port
  protocol                       = each.value.protocol
  scheduler                      = each.value.scheduler
  health_check_interval          = each.value.health_check_interval
  health_check_timeout_in_second = each.value.health_check_timeout_in_second
  health_check_type              = each.value.health_check_type
  health_check_uri               = each.value.health_check_uri
  health_check_port              = each.value.health_check_port
  health_check_string            = each.value.health_check_string
  healthy_threshold              = each.value.healthy_threshold
  server_timeout                 = each.value.server_timeout
  keep_session                   = each.value.keep_session
  cert_ids                       = each.value.cert_ids
}

resource "baiducloud_blb_backend_server" "this" {
  count = length(var.backend_servers) > 0 ? 1 : 0

  blb_id = baiducloud_blb.this.id

  dynamic "backend_server_list" {
    for_each = var.backend_servers
    content {
      instance_id = backend_server_list.value.instance_id
      weight      = backend_server_list.value.weight
    }
  }
}
