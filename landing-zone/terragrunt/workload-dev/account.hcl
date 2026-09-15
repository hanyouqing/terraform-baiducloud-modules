locals {
  organization = "example-corp"
  account_name = "workload-dev"
  account_type = "workload"
  account_id   = get_env("TF_VAR_workload_dev_account_id", "REPLACE_ME")
}
