module "compute" {
  source = "../../"

  eips = {
    web = {
      name              = "demo-web-eip"
      bandwidth_in_mbps = 50
      billing_method    = "ByTraffic"
    }
  }

  instances = {
    web-1 = {
      name                 = "demo-web-complete-1"
      image_id             = var.image_id
      availability_zone    = var.availability_zone
      subnet_id            = var.subnet_id
      instance_spec        = "bcc.g5.c2m8"
      security_groups      = var.security_group_ids
      keypair_id           = var.keypair_id
      root_disk_size_in_gb = 50
      eip_key              = "web"
      cds_disks = [
        {
          cds_size_in_gb = 100
          storage_type   = "cloud_hp1"
        }
      ]
    }
  }

  project     = "demo"
  environment = "production"
}
