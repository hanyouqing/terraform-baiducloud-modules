locals {
  module_tags = merge(
    {
      ManagedBy   = "terraform"
      Module      = "github.com/hanyouqing/terraform-baiducloud-modules/rds"
      Project     = var.project
      Environment = var.environment
    },
    var.tags
  )
}

resource "baiducloud_rds_instance" "this" {
  for_each = var.instances

  instance_name          = each.value.instance_name
  engine                 = each.value.engine
  engine_version         = each.value.engine_version
  cpu_count              = each.value.cpu_count
  memory_capacity        = each.value.memory_capacity
  volume_capacity        = each.value.volume_capacity
  disk_io_type           = each.value.disk_io_type
  category               = each.value.category
  vpc_id                 = each.value.vpc_id
  public_access          = each.value.public_access
  lower_case_table_names = each.value.lower_case_table_names
  parameter_template_id  = each.value.parameter_template_id
  resource_group_id      = each.value.resource_group_id
  backup_days            = each.value.backup_days
  backup_time            = each.value.backup_time
  replication_type       = each.value.replication_type
  auto_renew_time_unit   = each.value.auto_renew_time_unit
  auto_renew_time_length = each.value.auto_renew_time_length
  tags                   = local.module_tags
  reservation            = each.value.reservation

  billing = {
    payment_timing = each.value.payment_timing
  }

  dynamic "subnets" {
    for_each = each.value.subnets
    content {
      subnet_id = subnets.value.subnet_id
      zone_name = subnets.value.zone_name
    }
  }
}

resource "baiducloud_rds_readonly_instance" "this" {
  for_each = var.readonly_instances

  instance_name          = each.value.instance_name
  source_instance_id     = each.value.source_instance_key != null ? baiducloud_rds_instance.this[each.value.source_instance_key].instance_id : each.value.source_instance_id
  cpu_count              = each.value.cpu_count
  memory_capacity        = each.value.memory_capacity
  volume_capacity        = each.value.volume_capacity
  category               = each.value.category
  vpc_id                 = each.value.vpc_id
  auto_renew_time_unit   = each.value.auto_renew_time_unit
  auto_renew_time_length = each.value.auto_renew_time_length
  tags                   = local.module_tags
  reservation            = each.value.reservation

  billing = {
    payment_timing = each.value.payment_timing
  }

  dynamic "subnets" {
    for_each = each.value.subnets
    content {
      subnet_id = subnets.value.subnet_id
      zone_name = subnets.value.zone_name
    }
  }
}

resource "baiducloud_rds_account" "this" {
  for_each = var.accounts

  instance_id  = each.value.instance_key != null ? baiducloud_rds_instance.this[each.value.instance_key].instance_id : each.value.instance_id
  account_name = each.value.account_name
  password     = each.value.password
  account_type = each.value.account_type
  desc         = each.value.desc
}

resource "baiducloud_rds_security_ip" "this" {
  for_each = var.security_ips

  instance_id  = each.value.instance_key != null ? baiducloud_rds_instance.this[each.value.instance_key].instance_id : each.value.instance_id
  security_ips = each.value.security_ips
}
