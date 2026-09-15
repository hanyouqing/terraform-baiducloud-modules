variable "image_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "availability_zone" {
  type    = string
  default = "cn-bj-a"
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "keypair_id" {
  type    = string
  default = null
}
