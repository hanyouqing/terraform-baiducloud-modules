include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "envcommon" {
  path           = "${get_repo_root()}/terragrunt/_envcommon/vpc.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  name = "workload-dev-vpc"
}
