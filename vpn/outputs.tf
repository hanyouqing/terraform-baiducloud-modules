output "vpn_gateway_id" {
  description = "VPN gateway ID"
  value       = baiducloud_vpn_gateway.this.id
}

output "vpn_gateway_status" {
  description = "VPN gateway status"
  value       = baiducloud_vpn_gateway.this.status
}

output "vpn_eip" {
  description = "EIP bound to the VPN gateway"
  value       = local.vpn_eip
}

output "connection_ids" {
  description = "Map of VPN connection IDs"
  value       = { for k, v in baiducloud_vpn_conn.this : k => v.id }
}

output "connection_local_ips" {
  description = "Map of local public IPs for VPN connections"
  value       = { for k, v in baiducloud_vpn_conn.this : k => v.local_ip }
}
