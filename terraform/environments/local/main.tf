locals {
  values   = yamldecode(file("./values.yaml"))
  clusters = local.values.clusters
}

module "local-cluster" {
  source   = "../../modules/local-cluster"
  clusters = local.clusters
}
