terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../rds"
}

# Override in environment stacks:
# - development → basic single instance
# - production  → complete (replicas, accounts, security_ips)
inputs = {
  instances          = {}
  readonly_instances = {}
  accounts           = {}
  security_ips       = {}
}
