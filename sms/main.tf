resource "baiducloud_sms_signature" "this" {
  for_each = var.signatures

  content               = each.value.content
  content_type          = each.value.content_type
  country_type          = each.value.country_type
  description           = each.value.description
  signature_file_base64 = each.value.signature_file_base64
  signature_file_format = each.value.signature_file_format
}

resource "baiducloud_sms_template" "this" {
  for_each = var.templates

  name         = each.value.name
  content      = each.value.content
  sms_type     = each.value.sms_type
  country_type = each.value.country_type
  description  = each.value.description
}
