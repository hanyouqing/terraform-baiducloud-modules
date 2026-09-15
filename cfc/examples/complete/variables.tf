variable "vpc_id" { type = string }
variable "subnet_ids" { type = set(string) }
variable "security_group_ids" { type = set(string) }
