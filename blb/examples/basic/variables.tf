variable "vpc_id" { type = string }
variable "subnet_id" { type = string }
variable "backend_instance_ids" {
  type    = list(string)
  default = []
}
