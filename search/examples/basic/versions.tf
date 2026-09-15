terraform {
  required_version = ">= 1.14.2"
  required_providers {
    baiducloud = {
      source  = "baidubce/baiducloud"
      version = "~> 1.23"
    }
  }
}

provider "baiducloud" {
  # Credentials via BAIDUCLOUD_ACCESS_KEY / BAIDUCLOUD_SECRET_KEY / BAIDUCLOUD_REGION
}

