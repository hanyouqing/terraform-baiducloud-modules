locals {
  organization = "example-corp"
  account_name = "shared"
  account_type = "shared"
  account_id   = get_env("TF_VAR_shared_account_id", "REPLACE_ME")
}
