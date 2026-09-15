variable "account_name" {
  type        = string
  description = "Logical account name from Landing Zone catalog"
}

variable "account_id" {
  type        = string
  description = "Baidu Cloud account ID"
}

variable "federation_mode" {
  type    = string
  default = "role"
}

variable "identity_providers" {
  type    = any
  default = {}
}

variable "project" {
  type    = string
  default = "baiducloud-modules"
}

variable "environment" {
  type    = string
  default = "security"
}

variable "tags" {
  type    = map(string)
  default = {}
}
