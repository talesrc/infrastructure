locals {
  clusters   = yamldecode(file("${path.module}/../values/kubernetes.yaml")).clusters
}

module "local-cluster" {
  source   = "../../../modules/local-cluster"
  clusters = local.clusters
}
