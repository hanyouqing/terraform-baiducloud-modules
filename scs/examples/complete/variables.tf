variable "vpc_id" { type = string }
variable "subnet_id_a" { type = string }
variable "subnet_id_b" { type = string }
variable "zone_name_a" {
  type    = string
  default = "cn-bj-a"
}
variable "zone_name_b" {
  type    = string
  default = "cn-bj-b"
}
variable "security_group_ids" {
  type = list(string)
}
variable "client_auth" {
  type      = string
  sensitive = true
}
