# locals

locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  node_labels          = "cluster_name=${var.cluster_name}"
  register_with_taints = "" # "role=ops:NoSchedule"

  # kubelet_extra_args = [
  #   "--node-labels=${local.node_labels}",
  #   "--register-with-taints=${local.register_with_taints}",
  # ]

  kubelet_extra_args = "--node-labels=${local.node_labels} --register-with-taints=${local.register_with_taints}"

  user_data = <<EOF
#!/bin/bash -xe
/etc/eks/bootstrap.sh \
  --apiserver-endpoint '${var.cluster_endpoint}' \
  --b64-cluster-ca '${var.cluster_certificate_authority}' \
  --kubelet-extra-args '${local.kubelet_extra_args}' \
  '${var.cluster_name}'
EOF
}

locals {
  worker_tags = concat(
    [
      {
        key                 = "KubernetesCluster"
        value               = var.cluster_name
        propagate_at_launch = true
      },
      {
        key                 = "kubernetes.io/cluster/${var.cluster_name}"
        value               = "owned"
        propagate_at_launch = true
      },
      {
        key                 = "k8s.io/cluster-autoscaler/${var.cluster_name}"
        value               = "owned"
        propagate_at_launch = true
      },
      {
        key                 = "k8s.io/cluster-autoscaler/enabled"
        value               = "true"
        propagate_at_launch = true
      },
    ],
    var.tags,
  )
}
