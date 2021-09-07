# worker

resource "aws_eks_node_group" "worker" {
  count = var.enable_managed_nodegroup ? 1 : 0

  node_group_name_prefix = format("%s-", local.worker_name)

  cluster_name  = local.cluster_name
  node_role_arn = data.aws_iam_role.worker.arn
  subnet_ids    = local.subnet_ids

  launch_template = var.enable_spot ? aws_launch_template.worker_spot[0].id : aws_launch_template.worker[0].id

  # capacity_type  = "SPOT"       # ON_DEMAND, SPOT
  # ami_type       = "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64

  instance_types = local.instance_types

  labels = local.node_labels_map

  # TODO taint
  # taint = {
  #   effect = "NO_SCHEDULE"
  #   key    = "group"
  #   value  = var.name
  # }

  scaling_config {
    desired_size = var.min
    max_size     = var.max
    min_size     = var.min
  }

  update_config {
    max_unavailable_percentage = 20
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = local.eks_tags
}
