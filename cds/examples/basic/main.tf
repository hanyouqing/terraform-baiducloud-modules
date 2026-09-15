module "cds" {
  source = "../../"

  volumes = {
    data-1 = {
      name               = "demo-data-1"
      disk_size_in_gb    = 100
      storage_type       = "hp1"
      zone_name          = var.zone_name
      payment_timing     = "Postpaid"
      attach_instance_id = var.attach_instance_id
    }
  }

  project     = "demo"
  environment = "development"
}
