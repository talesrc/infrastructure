resource "kind_cluster" "main" {
  name       = var.cluster_name
  node_image = var.node_image

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    dynamic "node" {
      for_each = range(var.number_of_master_nodes)
      content {
        role = "control-plane"
        kubeadm_config_patches = [
          "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
        ]

        extra_port_mappings {
          container_port = 80
          host_port      = 80
        }
        extra_port_mappings {
          container_port = 443
          host_port      = 443
        }
      }
    }

    dynamic "node" {
      for_each = range(var.number_of_worker_nodes)
      content {
        role = "worker"
      }
    }
  }

  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml"
  }

  provisioner "local-exec" {
    command = "kubectl patch -n ingress-nginx deployment ingress-nginx-controller -p '{\"spec\":{\"template\":{\"spec\":{\"containers\":[{\"name\":\"controller\",\"resources\":{\"requests\":{\"cpu\":\"200m\",\"memory\":\"150Mi\"},\"limits\":{\"cpu\":\"500m\",\"memory\":\"300Mi\"}}}]}}}}'"
  }

  provisioner "local-exec" {
    command = "kubectl wait -n ingress-nginx --for=condition=ready --timeout=120s pod -l app.kubernetes.io/component=controller"
  }

  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml"
  }

  provisioner "local-exec" {
    command = "kubectl wait --namespace metallb-system --for=condition=ready pod --selector=app=metallb --timeout=90s"
  }

  provisioner "local-exec" {
    command = "kubectl apply -f - <<EOF\napiVersion: metallb.io/v1beta1\nkind: IPAddressPool\nmetadata:\n  name: load-balancer-default-pool\n  namespace: metallb-system\nspec:\n  addresses:\n  - 172.25.255.200-172.25.255.250\n---\napiVersion: metallb.io/v1beta1\nkind: L2Advertisement\nmetadata:\n  name: empty\n  namespace: metallb-system\nEOF"
  }
}
