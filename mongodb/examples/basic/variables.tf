variable "vpc_id" { type = string }
variable "subnet_id" { type = string }
variable "zone_name" {
  type    = string
  default = "cn-bj-a"
}
variable "account_password" {
  type      = string
  sensitive = true
}
