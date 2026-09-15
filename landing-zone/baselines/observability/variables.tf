variable "account_name" { type = string }
variable "environment" { type = string }
variable "project" {
  type    = string
  default = "baiducloud-modules"
}
variable "log_retention_days" {
  type    = number
  default = 90
}
variable "create_audit_bucket" {
  type    = bool
  default = true
}
variable "tags" {
  type    = map(string)
  default = {}
}
