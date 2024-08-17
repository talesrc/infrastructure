## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.12.1 |
| <a name="requirement_kind"></a> [kind](#requirement\_kind) | 0.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.12.1 |
| <a name="provider_kind"></a> [kind](#provider\_kind) | 0.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.metrics_server](https://registry.terraform.io/providers/hashicorp/helm/2.12.1/docs/resources/release) | resource |
| [helm_release.monitoring](https://registry.terraform.io/providers/hashicorp/helm/2.12.1/docs/resources/release) | resource |
| [kind_cluster.main](https://registry.terraform.io/providers/tehcyx/kind/0.2.1/docs/resources/cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clusters"></a> [clusters](#input\_clusters) | n/a | <pre>map(object({<br>    kubernetes_version = string<br>    number_of_master_nodes = number<br>    number_of_worker_nodes = number<br>    addons = optional(object({<br>      monitoring_enabled = optional(bool)<br>      hpa_enabled = optional(bool)<br>    }), {<br>      monitoring_enabled = false<br>      hpa_enabled = true<br>    })<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
