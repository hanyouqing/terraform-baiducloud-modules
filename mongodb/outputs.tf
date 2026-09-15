output "replica_instance_ids" {
  description = "Map of MongoDB replica instance IDs"
  value       = { for k, v in baiducloud_mongodb_instance.this : k => v.id }
}

output "replica_connection_strings" {
  description = "Map of MongoDB replica connection strings"
  value       = { for k, v in baiducloud_mongodb_instance.this : k => v.connection_string }
  sensitive   = true
}

output "replica_statuses" {
  description = "Map of MongoDB replica statuses"
  value       = { for k, v in baiducloud_mongodb_instance.this : k => v.status }
}

output "sharding_instance_ids" {
  description = "Map of MongoDB sharding instance IDs"
  value       = { for k, v in baiducloud_mongodb_sharding_instance.this : k => v.id }
}

output "sharding_connection_strings" {
  description = "Map of MongoDB sharding connection strings"
  value       = { for k, v in baiducloud_mongodb_sharding_instance.this : k => v.connection_string }
  sensitive   = true
}

output "sharding_statuses" {
  description = "Map of MongoDB sharding statuses"
  value       = { for k, v in baiducloud_mongodb_sharding_instance.this : k => v.status }
}
