locals {
  module_tags = merge(
    {
      ManagedBy   = "terraform"
      Module      = "github.com/hanyouqing/terraform-baiducloud-modules/ccev2"
      Project     = var.project
      Environment = var.environment
    },
    var.tags
  )
}

resource "baiducloud_ccev2_cluster" "this" {
  tags = local.module_tags

  cluster_spec {
    cluster_name = var.cluster_name
    cluster_type = var.cluster_type
    k8s_version  = var.k8s_version
    runtime_type = var.runtime_type
    vpc_id       = var.vpc_id
    plugins      = var.plugins
    description  = var.description

    master_config {
      master_type               = var.master_type
      cluster_ha                = var.cluster_ha
      exposed_public            = var.exposed_public
      cluster_blb_vpc_subnet_id = var.cluster_blb_vpc_subnet_id

      managed_cluster_master_option {
        master_vpc_subnet_zone = var.master_vpc_subnet_zone
      }
    }

    container_network_config {
      mode                     = var.container_network_mode
      lb_service_vpc_subnet_id = var.lb_service_vpc_subnet_id
      node_port_range_min      = var.node_port_range_min
      node_port_range_max      = var.node_port_range_max
      max_pods_per_node        = var.max_pods_per_node
      cluster_ip_service_cidr  = var.cluster_ip_service_cidr
      ip_version               = "ipv4"
      kube_proxy_mode          = var.kube_proxy_mode
      eni_security_group_id    = var.eni_security_group_id

      dynamic "eni_vpc_subnet_ids" {
        for_each = var.eni_vpc_subnet_zone_and_ids
        content {
          zone_and_id = eni_vpc_subnet_ids.value
        }
      }
    }

    cluster_delete_option {
      delete_resource     = var.delete_resource
      delete_cds_snapshot = var.delete_cds_snapshot
    }
  }
}
