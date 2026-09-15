locals {
  organization = "example-corp"
  account_name = "management"
  account_type = "management"
  account_id   = get_env("TF_VAR_management_account_id", "REPLACE_ME")
}
