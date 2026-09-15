resource "baiducloud_cfs" "this" {
  for_each = var.file_systems

  name     = each.value.name
  protocol = each.value.protocol
  type     = each.value.type
  zone     = each.value.zone
}

resource "baiducloud_cfs_mount_target" "this" {
  for_each = var.mount_targets

  fs_id     = baiducloud_cfs.this[each.value.fs_key].id
  vpc_id    = each.value.vpc_id
  subnet_id = each.value.subnet_id
}
