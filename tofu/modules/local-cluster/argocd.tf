resource "helm_release" "argocd" {
  for_each = { for k, v in var.clusters : k => v if v.addons.argocd.control_plane }
  name     = "argocd"

  repository = local.helm_repository
  chart      = "argocd"
  namespace  = "argocd"

  create_namespace  = true
  dependency_update = true
  wait_for_jobs     = true

  depends_on = [kind_cluster.main]

  lifecycle {
    replace_triggered_by = [kind_cluster.main]
  }
}
