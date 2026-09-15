module "compute" {
  source = "../../"

  instances = {
    web-1 = {
      name                 = "demo-web-1"
      image_id             = var.image_id
      availability_zone    = var.availability_zone
      subnet_id            = var.subnet_id
      instance_spec        = "bcc.g5.c2m8"
      security_groups      = var.security_group_ids
      keypair_id           = var.keypair_id
      root_disk_size_in_gb = 40
    }
  }

  project     = "demo"
  environment = "development"
}
