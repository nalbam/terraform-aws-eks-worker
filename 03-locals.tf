# locals

locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  node_labels = var.node_labels != "" ? "--node-labels=${var.node_labels}" : ""
  node_taints = var.node_taints != "" ? "--register-with-taints=${var.node_taints}" : ""

  extra_args = "${local.node_labels} ${local.node_taints}"

  user_data = <<EOF
#!/bin/bash -xe
/etc/eks/bootstrap.sh \
  --apiserver-endpoint '${var.cluster_endpoint}' \
  --b64-cluster-ca '${var.cluster_certificate_authority}' \
  --kubelet-extra-args '${local.extra_args}' \
  '${var.cluster_name}'
EOF
}

locals {
  def_tags = {
    "KubernetesCluster"                         = var.cluster_name
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }

  asg_tags = {
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"             = "true"
  }

  merge_tags = merge(
    local.def_tags,
    var.autoscale_enable ? local.asg_tags : {},
    var.tags,
  )

  tags = [
    for item in keys(local.merge_tags) :
    map(
      "key", item,
      "value", element(values(local.merge_tags), index(keys(local.merge_tags), item)),
      "propagate_at_launch", true,
    )
  ]
}
