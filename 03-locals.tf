# locals

locals {
  # account_id = var.account_id
}

locals {
  subgroup = var.subname == "" ? var.name : format("%s-%s", var.name, var.subname)
  fullname = var.vername == "" ? local.subgroup : format("%s-%s", local.subgroup, var.vername)

  cluster_name = var.cluster_name
  worker_group = format("%s-%s", local.cluster_name, var.name)
  worker_name  = format("%s-%s", local.cluster_name, local.fullname)

  instance_types = compact(concat([var.instance_type], var.mixed_instances))

  instance_profile_name = var.instance_profile_name != "" ? var.instance_profile_name : aws_iam_instance_profile.worker.name
}

locals {
  ami_arch    = var.ami_arch == "arm64" ? "amazon-eks-arm64-node" : "amazon-eks-node"
  ami_keyword = format("%s-%s-%s", local.ami_arch, var.kubernetes_version, var.ami_keyword)

  ami_id = var.ami_id != "" ? var.ami_id : data.aws_ami.worker[0].id
}

locals {
  instance_market_options = var.enable_spot ? [{
    "market_type" = "spot"
  }] : []

  launch_template = var.enable_mixed == false ? [{
    "template_id" = aws_launch_template.worker.id
  }] : []

  mixed_instances_policy = var.enable_mixed == true ? [{
    "on_demand_base" = var.on_demand_base
    "on_demand_rate" = var.on_demand_rate
    "spot_strategy"  = var.spot_strategy
    "template_id"    = aws_launch_template.worker.id
  }] : []
}

locals {
  node_labels_map = merge(
    {
      "group"                       = var.name
      "instancegroup"               = local.fullname
      "subgroup"                    = local.subgroup
      "eks.amazonaws.com/nodegroup" = var.name
    },
    var.subname != "" ? {
      "subname" = var.subname
    } : {},
    var.vername != "" ? {
      "vername" = var.vername
    } : {},
    var.node_labels,
  )

  enable_taints = var.name == "workers" ? false : var.enable_taints

  node_labels = replace(replace(jsonencode(local.node_labels_map), "/[\\{\\}\"\\s]/", ""), ":", "=")
  node_taints = local.enable_taints ? format("--register-with-taints=group=%s:NoSchedule", var.name) : ""
  log_levels  = var.log_levels > 0 ? format("--v=%s", var.log_levels) : ""

  extra_args = "${var.additional_extra_args} ${local.node_taints} ${local.log_levels} --node-labels=${local.node_labels}"

  user_data = <<EOF
#!/bin/bash -xe

mkdir -p ~/.docker /var/lib/kubelet
aws ssm get-parameter --name "/k8s/common/docker-config" --with-decryption --output text --query Parameter.Value > ~/.docker/config.json
aws ssm get-parameter --name "/k8s/common/docker-config" --with-decryption --output text --query Parameter.Value > /var/lib/kubelet/config.json
aws ssm get-parameter --name "/k8s/common/containerd-config" --with-decryption --output text --query Parameter.Value >> /etc/eks/containerd/containerd-config.toml

aws_region=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/\(.*\)[a-z]/\1/')
aws_instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
aws_instance_lifecycle=$(curl -s http://169.254.169.254/latest/meta-data/instance-life-cycle)
aws ec2 create-tags --resources $aws_instance_id --region $aws_region --tags Key=Lifecycle,Value=$aws_instance_lifecycle

levels="lifecycle=$aws_instance_lifecycle"

${var.additional_user_data}

/etc/eks/bootstrap.sh \
  --apiserver-endpoint '${var.cluster_endpoint}' \
  --b64-cluster-ca '${var.cluster_certificate_authority}' \
  --kubelet-extra-args "${local.extra_args},$levels" \
  '${local.cluster_name}'
EOF
}

locals {
  tags = merge(
    var.tags,
    {
      "Name"                                        = local.worker_name
      "KubernetesCluster"                           = local.cluster_name
      "KubernetesNodeGroup"                         = local.worker_group
      "kubernetes.io/cluster/${local.cluster_name}" = "owned"
    },
  )

  eks_tags = merge(
    local.tags,
    var.enable_autoscale ? {
      "k8s.io/cluster-autoscaler/${local.cluster_name}" = "owned"
      "k8s.io/cluster-autoscaler/enabled"               = "true"
    } : {},
    var.enable_event ? {
      "aws-node-termination-handler/${local.cluster_name}" = "owned"
      "aws-node-termination-handler/managed"               = "true"
    } : {},
  )
}
