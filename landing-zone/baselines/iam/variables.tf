variable "account_name" {
  type        = string
  description = "Logical account name from the landing-zone catalog"
}

variable "environment" {
  type        = string
  description = "Environment label for this account (e.g. management, security, shared, development, production)"
}

variable "project" {
  type    = string
  default = "baiducloud-modules"
}

variable "create_cicd_user" {
  type        = bool
  description = "Create a CI/CD IAM user with access key"
  default     = true
}

variable "create_breakglass_user" {
  type        = bool
  description = "Create an emergency break-glass IAM user (no access key by default)"
  default     = true
}

variable "cicd_policy_document" {
  type        = string
  description = "JSON IAM policy document for the CI/CD user. Defaults to a least-privilege-ish BOS/BCC read+deploy starter."
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
