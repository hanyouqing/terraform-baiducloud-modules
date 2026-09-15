terraform {
  required_version = ">= 1.14.2"
  required_providers {
    baiducloud = {
      source  = "baidubce/baiducloud"
      version = "~> 1.23"
    }
  }
}
