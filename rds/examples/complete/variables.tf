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
variable "db_password" {
  type      = string
  sensitive = true
}
variable "app_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
