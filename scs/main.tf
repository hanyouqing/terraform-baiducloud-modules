locals {
  module_tags = merge(
    {
      ManagedBy   = "terraform"
      Module      = "github.com/hanyouqing/terraform-baiducloud-modules/scs"
      Project     = var.project
      Environment = var.environment
    },
    var.tags
  )
}

resource "baiducloud_scs" "this" {
  for_each = var.instances

  instance_name          = each.value.instance_name
  node_type              = each.value.node_type
  payment_timing         = each.value.payment_timing
  engine                 = each.value.engine
  engine_version         = each.value.engine == "redis" ? each.value.engine_version : null
  cluster_type           = each.value.cluster_type
  port                   = each.value.port
  shard_num              = each.value.shard_num
  replication_num        = each.value.replication_num
  proxy_num              = each.value.proxy_num
  client_auth            = each.value.client_auth
  vpc_id                 = each.value.vpc_id
  security_groups        = length(each.value.security_groups) > 0 ? each.value.security_groups : null
  backup_days            = each.value.backup_days
  backup_time            = each.value.backup_time
  store_type             = each.value.store_type
  disk_flavor            = each.value.disk_flavor
  disk_type              = each.value.disk_type
  enable_read_only       = each.value.enable_read_only
  reservation_length     = each.value.reservation_length
  reservation_time_unit  = each.value.reservation_time_unit
  auto_renew             = each.value.auto_renew
  auto_renew_time_unit   = each.value.auto_renew_time_unit
  auto_renew_time_length = each.value.auto_renew_time_length
  resource_group_id      = each.value.resource_group_id
  tags                   = local.module_tags

  dynamic "subnets" {
    for_each = each.value.subnets
    content {
      subnet_id = subnets.value.subnet_id
      zone_name = subnets.value.zone_name
    }
  }

  dynamic "replication_info" {
    for_each = each.value.replication_info
    content {
      availability_zone = replication_info.value.availability_zone
      subnet_id         = replication_info.value.subnet_id
      is_master         = replication_info.value.is_master
    }
  }
}
