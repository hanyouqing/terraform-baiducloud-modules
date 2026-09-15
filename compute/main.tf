locals {
  module_tags = merge(
    {
      ManagedBy   = "terraform"
      Module      = "github.com/hanyouqing/terraform-baiducloud-modules/compute"
      Project     = var.project
      Environment = var.environment
    },
    var.tags
  )
}

resource "baiducloud_eip" "this" {
  for_each = var.eips

  name              = each.value.name != null ? each.value.name : each.key
  bandwidth_in_mbps = each.value.bandwidth_in_mbps
  payment_timing    = each.value.payment_timing
  billing_method    = each.value.billing_method
  route_type        = each.value.route_type
  tags              = local.module_tags
}

resource "baiducloud_instance" "this" {
  for_each = var.instances

  name                       = each.value.name
  image_id                   = each.value.image_id
  availability_zone          = each.value.availability_zone
  subnet_id                  = each.value.subnet_id
  instance_spec              = each.value.instance_spec
  cpu_count                  = each.value.cpu_count
  memory_capacity_in_gb      = each.value.memory_capacity_in_gb
  payment_timing             = each.value.payment_timing
  root_disk_size_in_gb       = each.value.root_disk_size_in_gb
  root_disk_storage_type     = each.value.root_disk_storage_type
  security_groups            = length(each.value.security_groups) > 0 ? each.value.security_groups : null
  enterprise_security_groups = length(each.value.enterprise_security_groups) > 0 ? each.value.enterprise_security_groups : null
  keypair_id                 = each.value.keypair_id
  admin_pass                 = each.value.admin_pass
  hostname                   = each.value.hostname
  description                = each.value.description != "" ? each.value.description : null
  user_data                  = each.value.user_data
  action                     = each.value.action
  related_release_flag       = each.value.related_release_flag
  stop_with_no_charge        = each.value.stop_with_no_charge
  resource_group_id          = each.value.resource_group_id
  tags                       = local.module_tags
  reservation                = each.value.reservation

  dynamic "cds_disks" {
    for_each = each.value.cds_disks
    content {
      cds_size_in_gb = cds_disks.value.cds_size_in_gb
      storage_type   = cds_disks.value.storage_type
      snapshot_id    = cds_disks.value.snapshot_id
    }
  }

  lifecycle {
    ignore_changes = [admin_pass, user_data]
    precondition {
      condition     = each.value.instance_spec != null || (each.value.cpu_count != null && each.value.memory_capacity_in_gb != null)
      error_message = "Set instance_spec or both cpu_count and memory_capacity_in_gb for each instance."
    }
  }
}

resource "baiducloud_eip_association" "this" {
  for_each = {
    for k, v in var.instances : k => v
    if v.eip_key != null
  }

  eip           = baiducloud_eip.this[each.value.eip_key].eip
  instance_type = "BCC"
  instance_id   = baiducloud_instance.this[each.key].id
}
