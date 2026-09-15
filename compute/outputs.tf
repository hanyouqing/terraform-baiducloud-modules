output "instance_ids" {
  description = "Map of BCC instance IDs"
  value       = { for k, v in baiducloud_instance.this : k => v.id }
}

output "instance_names" {
  description = "Map of BCC instance names"
  value       = { for k, v in baiducloud_instance.this : k => v.name }
}

output "internal_ips" {
  description = "Map of BCC internal IPs"
  value       = { for k, v in baiducloud_instance.this : k => v.internal_ip }
}

output "public_ips" {
  description = "Map of BCC public IPs (if any)"
  value       = { for k, v in baiducloud_instance.this : k => v.public_ip }
}

output "eip_addresses" {
  description = "Map of EIP addresses created by this module"
  value       = { for k, v in baiducloud_eip.this : k => v.eip }
}

output "instances" {
  description = "Full instance attribute map"
  value = {
    for k, v in baiducloud_instance.this : k => {
      id          = v.id
      name        = v.name
      internal_ip = v.internal_ip
      public_ip   = v.public_ip
      status      = v.status
      vpc_id      = v.vpc_id
    }
  }
}
