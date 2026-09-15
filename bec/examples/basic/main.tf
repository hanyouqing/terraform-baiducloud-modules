module "bec" {
  source = "../../"

  instances = {
    edge-1 = {
      service_id           = var.service_id
      region_id            = var.region_id
      image_id             = var.image_id
      cpu                  = 2
      memory               = 4
      vm_name              = "demo-bec-1"
      key_type             = "bccKeyPair"
      bcc_key_pair_id_list = [var.keypair_id]
      system_volume = {
        name        = "sys"
        size_in_gb  = 40
        volume_type = "NVME"
      }
    }
  }

  project     = "demo"
  environment = "development"
}
