output "cluster_id" {
  description = "CCEv2 cluster ID"
  value       = baiducloud_ccev2_cluster.this.id
}

output "cluster_status" {
  description = "CCEv2 cluster status object"
  value       = baiducloud_ccev2_cluster.this.cluster_status
}

output "created_at" {
  description = "Cluster creation time"
  value       = baiducloud_ccev2_cluster.this.created_at
}
