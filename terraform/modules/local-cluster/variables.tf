variable "clusters" {
  type = map(object({
    kubernetes_version = string
    number_of_master_nodes = number
    number_of_worker_nodes = number
    addons = optional(object({
      monitoring_enabled = optional(bool)
      hpa_enabled = optional(bool)
    }), {
      monitoring_enabled = false
      hpa_enabled = true
    })
  }))
}
