output "peer_conn_ids" {
  description = "Map of peer connection IDs"
  value       = { for k, v in baiducloud_peer_conn.this : k => v.id }
}

output "statuses" {
  description = "Map of peer connection statuses"
  value       = { for k, v in baiducloud_peer_conn.this : k => v.status }
}

output "local_if_ids" {
  description = "Map of local interface IDs"
  value       = { for k, v in baiducloud_peer_conn.this : k => v.local_if_id }
}
