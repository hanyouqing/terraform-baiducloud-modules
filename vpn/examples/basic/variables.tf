variable "vpc_id" { type = string }
variable "local_subnets" { type = list(string) }
variable "remote_ip" { type = string }
variable "remote_subnets" { type = list(string) }
variable "secret_key" {
  type      = string
  sensitive = true
}
