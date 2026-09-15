module "kafka" {
  source = "../../"

  cluster_name = "demo-kafka"
  project      = "demo"
  environment  = "development"
}
