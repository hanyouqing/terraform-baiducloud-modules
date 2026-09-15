module "ccev2" {
  source = "../../"

  cluster_name                = "demo-cce"
  vpc_id                      = var.vpc_id
  cluster_blb_vpc_subnet_id   = var.subnet_id
  lb_service_vpc_subnet_id    = var.subnet_id
  eni_security_group_id       = var.security_group_id
  eni_vpc_subnet_zone_and_ids = ["zoneA:${var.subnet_id}"]
  master_vpc_subnet_zone      = "zoneA"
  k8s_version                 = "1.30.1"
  exposed_public              = false

  project     = "demo"
  environment = "development"
}
