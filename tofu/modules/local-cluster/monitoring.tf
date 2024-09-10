resource "helm_release" "monitoring" {
  for_each = {for k, v in var.clusters : k => v if v.addons.monitoring_enabled}
  name  = "kube-prometheus"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  create_namespace = true
  namespace        = "monitoring"

  depends_on = [kind_cluster.main]

  lifecycle {
    replace_triggered_by = [kind_cluster.main]
  }
}
