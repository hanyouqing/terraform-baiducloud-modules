locals {
  organization = "example-corp"
  account_name = "security"
  account_type = "security"
  account_id   = get_env("TF_VAR_security_account_id", "REPLACE_ME")
}
