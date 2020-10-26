# locals

locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  name = format("%s-%s", var.cluster_name, var.name)
}

locals {
  vpc_id     = var.vpc_id != "" ? var.vpc_id : data.aws_eks_cluster.cluster.vpc_config["vpc_id"]
  subnet_ids = var.subnet_ids != "" ? var.subnet_ids : data.aws_eks_cluster.cluster.vpc_config["subnet_ids"]

  worker_ami_prefix = format("amazon-eks-node-%s-*", data.aws_eks_cluster.cluster.version)

  worker_ami_id = var.worker_ami_id != "" ? var.worker_ami_id : data.aws_ami.worker.id
}

locals {
  node_labels = var.node_labels != "" ? "--node-labels=${var.node_labels}" : ""
  node_taints = var.node_taints != "" ? "--register-with-taints=${var.node_taints}" : ""

  extra_args = "${local.node_labels} ${local.node_taints}"

  user_data = <<EOF
#!/bin/bash -xe
/etc/eks/bootstrap.sh \
  --apiserver-endpoint '${data.aws_eks_cluster.cluster.endpoint}' \
  --b64-cluster-ca '${data.aws_eks_cluster.cluster.certificate_authority.0.data}' \
  --kubelet-extra-args '${local.extra_args}' \
  '${var.cluster_name}'
EOF
}

locals {
  def_tags = {
    "Name"                                      = local.name
    "KubernetesCluster"                         = var.cluster_name
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }

  asg_tags = {
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"             = "true"
  }

  tags = merge(
    var.tags,
    var.autoscale_enable ? local.asg_tags : {},
    local.def_tags,
  )
}
