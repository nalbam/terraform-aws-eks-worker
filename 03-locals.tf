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

  instance_profile_name = var.instance_profile_name != "" ? var.instance_profile_name : aws_iam_instance_profile.worker.name
}

locals {
  worker_asg_ids = compact(concat(
    aws_autoscaling_group.worker.*.id,
    aws_autoscaling_group.worker_mixed.*.id,
  ))

  worker_asg_arns = compact(concat(
    aws_autoscaling_group.worker.*.arn,
    aws_autoscaling_group.worker_mixed.*.arn,
  ))

  worker_asg_names = compact(concat(
    aws_autoscaling_group.worker.*.name,
    aws_autoscaling_group.worker_mixed.*.name,
  ))

  worker_lt_ids = compact(concat(
    aws_launch_template.worker.*.id,
    aws_launch_template.worker_spot.*.id,
  ))
}

locals {
  node_labels_map = merge(
    {
      "group"         = var.name
      "subgroup"      = local.subgroup
      "instancegroup" = local.fullname
      "lifecycle"     = var.enable_spot ? "spot" : "normal"
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
    var.enable_event ? {
      "aws-node-termination-handler/managed" = "true"
    } : {},
  )
}
