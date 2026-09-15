module "cfs" {
  source = "../../"

  file_systems = {
    shared = {
      name     = "demo-cfs"
      protocol = "nfs"
      zone     = var.zone
    }
  }

  mount_targets = {
    mt-1 = {
      fs_key    = "shared"
      vpc_id    = var.vpc_id
      subnet_id = var.subnet_id
    }
  }

  project     = "demo"
  environment = "development"
}
