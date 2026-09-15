locals {
  module_tags = merge(
    {
      ManagedBy   = "terraform"
      Module      = "github.com/hanyouqing/terraform-baiducloud-modules/mongodb"
      Project     = var.project
      Environment = var.environment
    },
    var.tags
  )
}

resource "baiducloud_mongodb_instance" "this" {
  for_each = var.replica_instances

  name                    = each.value.name
  cpu_count               = each.value.cpu_count
  memory_capacity         = each.value.memory_capacity
  storage                 = each.value.storage
  storage_type            = each.value.storage_type
  storage_engine          = each.value.storage_engine
  engine_version          = each.value.engine_version
  payment_timing          = each.value.payment_timing
  account_password        = each.value.account_password
  vpc_id                  = each.value.vpc_id
  security_ip             = length(each.value.security_ip) > 0 ? each.value.security_ip : null
  voting_member_num       = each.value.voting_member_num
  readonly_node_num       = each.value.readonly_node_num
  auto_backup_enable      = each.value.auto_backup_enable
  preferred_backup_period = length(each.value.preferred_backup_period) > 0 ? each.value.preferred_backup_period : null
  preferred_backup_time   = each.value.preferred_backup_time
  enable_increment_backup = each.value.enable_increment_backup
  reservation_length      = each.value.reservation_length
  auto_renew_length       = each.value.auto_renew_length
  resource_group_id       = each.value.resource_group_id
  tags                    = local.module_tags

  dynamic "subnets" {
    for_each = each.value.subnets
    content {
      subnet_id = subnets.value.subnet_id
      zone_name = subnets.value.zone_name
    }
  }
}

resource "baiducloud_mongodb_sharding_instance" "this" {
  for_each = var.sharding_instances

  name                   = each.value.name
  mongos_count           = each.value.mongos_count
  mongos_cpu_count       = each.value.mongos_cpu_count
  mongos_memory_capacity = each.value.mongos_memory_capacity
  shard_count            = each.value.shard_count
  shard_cpu_count        = each.value.shard_cpu_count
  shard_memory_capacity  = each.value.shard_memory_capacity
  shard_storage          = each.value.shard_storage
  shard_storage_type     = each.value.shard_storage_type
  storage_engine         = each.value.storage_engine
  engine_version         = each.value.engine_version
  payment_timing         = each.value.payment_timing
  account_password       = each.value.account_password
  vpc_id                 = each.value.vpc_id
  security_ip            = length(each.value.security_ip) > 0 ? each.value.security_ip : null
  reservation_length     = each.value.reservation_length
  auto_renew_length      = each.value.auto_renew_length
  resource_group_id      = each.value.resource_group_id
  tags                   = local.module_tags

  dynamic "subnets" {
    for_each = each.value.subnets
    content {
      subnet_id = subnets.value.subnet_id
      zone_name = subnets.value.zone_name
    }
  }
}
