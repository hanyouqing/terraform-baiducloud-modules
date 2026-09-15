resource "baiducloud_cfc_function" "this" {
  for_each = var.functions

  function_name                  = each.value.function_name
  description                    = each.value.description
  handler                        = each.value.handler
  runtime                        = each.value.runtime
  time_out                       = each.value.time_out
  memory_size                    = each.value.memory_size
  reserved_concurrent_executions = each.value.reserved_concurrent_executions
  environment                    = length(each.value.environment) > 0 ? each.value.environment : null
  code_file_name                 = each.value.code_file_name
  code_file_dir                  = each.value.code_file_dir
  code_bos_bucket                = each.value.code_bos_bucket
  code_bos_object                = each.value.code_bos_object
  log_type                       = each.value.log_type
  log_bos_dir                    = each.value.log_bos_dir

  dynamic "vpc_config" {
    for_each = each.value.vpc_config == null ? [] : [each.value.vpc_config]
    content {
      vpc_id             = vpc_config.value.vpc_id
      subnet_ids         = vpc_config.value.subnet_ids
      security_group_ids = vpc_config.value.security_group_ids
    }
  }
}

resource "baiducloud_cfc_version" "this" {
  for_each = {
    for k, v in var.functions : k => v
    if v.publish_version
  }

  function_name       = baiducloud_cfc_function.this[each.key].function_name
  version_description = each.value.version_description

  depends_on = [baiducloud_cfc_function.this]
}

resource "baiducloud_cfc_alias" "this" {
  for_each = var.aliases

  function_name    = each.value.function_key != null ? baiducloud_cfc_function.this[each.value.function_key].function_name : each.value.function_name
  function_version = each.value.function_version == "published" && each.value.function_key != null ? baiducloud_cfc_version.this[each.value.function_key].version : each.value.function_version
  alias_name       = each.value.alias_name
  description      = each.value.description
}

resource "baiducloud_cfc_trigger" "this" {
  for_each = var.triggers

  target              = each.value.function_key != null ? baiducloud_cfc_function.this[each.value.function_key].function_brn : each.value.target
  source_type         = each.value.source_type
  name                = each.value.name
  enabled             = each.value.enabled
  schedule_expression = each.value.schedule_expression
  bucket              = each.value.bucket
  bos_event_type      = length(each.value.bos_event_type) > 0 ? each.value.bos_event_type : null
  resource            = each.value.resource
  domain              = each.value.domain
  cdn_event_type      = each.value.cdn_event_type
  method              = length(each.value.method) > 0 ? each.value.method : null
  auth_type           = each.value.auth_type
  resource_path       = each.value.resource_path
  input               = each.value.input
  remark              = each.value.remark
  status              = each.value.status
}
