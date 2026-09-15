terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../dns"
}
