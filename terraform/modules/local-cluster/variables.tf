variable "clusters" {
  type = map(object({
    kubernetes_version     = string
    number_of_master_nodes = number
    number_of_worker_nodes = number
    addons = optional(object({
      argocd = optional(object({
        control_plane = optional(bool)
        join_cluster  = optional(string)
      }))
      monitoring_enabled = optional(bool, false)
      hpa_enabled        = optional(bool, true)
    }))
  }))
}
