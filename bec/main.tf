resource "baiducloud_bec_vm_instance" "this" {
  for_each = var.instances

  service_id          = each.value.service_id
  region_id           = each.value.region_id
  image_id            = each.value.image_id
  cpu                 = each.value.cpu
  memory              = each.value.memory
  vm_name             = each.value.vm_name
  host_name           = each.value.host_name
  image_type          = each.value.image_type
  need_public_ip      = each.value.need_public_ip
  need_ipv6_public_ip = each.value.need_ipv6_public_ip
  bandwidth           = each.value.bandwidth
  network_type        = each.value.network_type
  vpc_id              = each.value.vpc_id
  subnet_id           = each.value.subnet_id
  payment_method      = each.value.payment_method
  spec                = each.value.spec

  dns_config {
    dns_type    = each.value.dns_type
    dns_address = each.value.dns_address
  }

  key_config {
    type                 = each.value.key_type
    admin_pass           = each.value.admin_pass
    bcc_key_pair_id_list = length(each.value.bcc_key_pair_id_list) > 0 ? each.value.bcc_key_pair_id_list : null
  }

  system_volume {
    name        = each.value.system_volume.name
    size_in_gb  = each.value.system_volume.size_in_gb
    volume_type = each.value.system_volume.volume_type
  }

  dynamic "data_volume" {
    for_each = each.value.data_volumes
    content {
      name        = data_volume.value.name
      size_in_gb  = data_volume.value.size_in_gb
      volume_type = data_volume.value.volume_type
    }
  }
}
