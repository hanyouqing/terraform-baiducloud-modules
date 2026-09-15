resource "baiducloud_cert" "this" {
  for_each = toset(nonsensitive(keys(var.certificates)))

  cert_name         = var.certificates[each.key].cert_name
  cert_server_data  = var.certificates[each.key].cert_server_data
  cert_private_data = var.certificates[each.key].cert_private_data
  cert_link_data    = var.certificates[each.key].cert_link_data
  cert_type         = var.certificates[each.key].cert_type
}
