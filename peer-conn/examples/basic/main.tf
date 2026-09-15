module "peer_conn" {
  source = "../../"

  connections = {
    to-peer = {
      bandwidth_in_mbps = 100
      local_vpc_id      = var.local_vpc_id
      peer_vpc_id       = var.peer_vpc_id
      peer_region       = var.peer_region
      payment_timing    = "Postpaid"
      description       = "demo peer connection"
    }
  }

  project     = "demo"
  environment = "development"
}
