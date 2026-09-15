include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/kafka.hcl"
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  cluster_name = "prod-kafka"
  tags = {
    Tier = "messaging"
  }
}
