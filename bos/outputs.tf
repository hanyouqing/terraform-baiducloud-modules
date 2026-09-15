output "bucket_ids" {
  description = "Map of BOS bucket IDs/names"
  value       = { for k, v in baiducloud_bos_bucket.this : k => v.id }
}

output "bucket_names" {
  description = "Map of BOS bucket names"
  value       = { for k, v in baiducloud_bos_bucket.this : k => v.bucket }
}

output "bucket_acls" {
  description = "Map of BOS bucket ACLs"
  value       = { for k, v in baiducloud_bos_bucket.this : k => v.acl }
}
