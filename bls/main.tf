resource "baiducloud_bls_log_store" "this" {
  for_each = var.log_stores

  log_store_name = each.value.log_store_name
  retention      = each.value.retention
}
