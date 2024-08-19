variable "clusters" {
  type = map(object({
    kubernetes_version     = string
    number_of_master_nodes = number
    number_of_worker_nodes = number
    addons = optional(object({
      argocd = object({
        control_plane = bool
        join_cluster  = string
      })
      monitoring_enabled = optional(bool, false)
      hpa_enabled        = optional(bool, true)
    }))
  }))
}
