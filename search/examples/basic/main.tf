module "search" {
  source = "../../"

  cluster_name = "demo-bes"
  project      = "demo"
  environment  = "development"
}
