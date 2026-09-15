module "vpn" {
  source = "../../"

  vpn_name   = "demo-vpn"
  vpc_id     = var.vpc_id
  create_eip = true

  connections = {
    onprem = {
      vpn_conn_name  = "demo-to-onprem"
      secret_key     = var.secret_key
      local_subnets  = var.local_subnets
      remote_ip      = var.remote_ip
      remote_subnets = var.remote_subnets
      ike_config = {
        ike_version   = "v1"
        ike_mode      = "main"
        ike_enc_alg   = "aes"
        ike_auth_alg  = "sha1"
        ike_pfs       = "group2"
        ike_life_time = 86400
      }
      ipsec_config = {
        ipsec_enc_alg   = "aes"
        ipsec_auth_alg  = "sha1"
        ipsec_pfs       = "group2"
        ipsec_life_time = 3600
      }
    }
  }

  project     = "demo"
  environment = "development"
}
