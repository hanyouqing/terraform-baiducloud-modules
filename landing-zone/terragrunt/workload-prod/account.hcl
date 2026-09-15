locals {
  organization = "example-corp"
  account_name = "workload-prod"
  account_type = "workload"
  account_id   = get_env("TF_VAR_workload_prod_account_id", "REPLACE_ME")
}
