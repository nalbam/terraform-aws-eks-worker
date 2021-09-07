# locals

locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  subgroup = var.subname == "" ? var.name : format("%s-%s", var.name, var.subname)
  fullname = var.vername == "" ? local.subgroup : format("%s-%s", local.subgroup, var.vername)

  cluster_name = var.cluster_info.name
  worker_name  = format("%s-%s", local.cluster_name, local.fullname)

  worker_ami_arch    = var.worker_ami_arch == "arm64" ? "amazon-eks-arm64-node" : "amazon-eks-node"
  worker_ami_keyword = format("%s-%s-%s", local.worker_ami_arch, var.cluster_info.version, var.worker_ami_keyword)

  instance_types = compact(concat([var.instance_type], var.mixed_instances))

  ami_id = var.ami_id != "" ? var.ami_id : data.aws_ami.worker.id
}

locals {
  node_labels_map = merge(
    {
      "group"         = var.name
      "subgroup"      = local.subgroup
      "instancegroup" = local.fullname
    },
    var.node_labels,
  )

  node_labels = replace(replace(jsonencode(local.node_labels_map), "/[\\{\\}\"\\s]/", ""), ":", "=")
  node_taints = var.enable_taints ? format("--register-with-taints=group=%s:NoSchedule", var.name) : ""
  log_levels  = var.log_levels > 0 ? format("--v=%s", var.log_levels) : ""

  extra_args = "--node-labels=${local.node_labels} ${local.node_taints} ${local.log_levels}"

  user_data = <<EOF
#!/bin/bash -xe
mkdir -p ~/.docker && echo '${data.aws_ssm_parameter.docker_config.value}' > ~/.docker/config.json
mkdir -p /var/lib/kubelet && echo '${data.aws_ssm_parameter.docker_config.value}' > /var/lib/kubelet/config.json
/etc/eks/bootstrap.sh \
  --apiserver-endpoint '${var.cluster_info.endpoint}' \
  --b64-cluster-ca '${var.cluster_info.certificate_authority}' \
  --kubelet-extra-args '${local.extra_args}' \
  '${local.cluster_name}'
EOF
}

locals {
  tags = merge(
    var.tags,
    {
      "Name"                                        = local.worker_name
      "KubernetesCluster"                           = local.cluster_name
      "kubernetes.io/cluster/${local.cluster_name}" = "owned"
      "krmt.io/group"                               = var.name
      "krmt.io/subgroup"                            = local.subgroup
      "krmt.io/instancegroup"                       = local.fullname
    },
  )

  eks_tags = merge(
    local.tags,
    var.enable_autoscale ? {
      "k8s.io/cluster-autoscaler/${local.cluster_name}" = "owned"
      "k8s.io/cluster-autoscaler/enabled"               = "true"
    } : {},
  )

  asg_tags = [
    for item in keys(local.eks_tags) :
    tomap({
      "key"                 = item
      "value"               = element(values(local.eks_tags), index(keys(local.eks_tags), item))
      "propagate_at_launch" = true
    })
  ]
}
