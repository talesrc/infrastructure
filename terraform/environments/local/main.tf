module "local-cluster" {
  source       = "../../modules/local-cluster"
  cluster_name = "taleco-cluster"

  number_of_master_nodes = 1
  number_of_worker_nodes = 1

  install_monitoring = false
  enable_hpa         = false
}
