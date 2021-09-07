# worker for single

resource "aws_autoscaling_group" "worker" {
  count = length(local.instance_types) == 1 ? 1 : 0

  name_prefix = format("%s-", local.worker_name)

  min_size = var.min
  max_size = var.max

  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = var.target_group_arns

  launch_template {
    id      = var.enable_spot ? aws_launch_template.worker_spot[0].id : aws_launch_template.worker[0].id
    version = "$Latest"
  }

  enabled_metrics = var.enabled_metrics

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }

  tags = local.asg_tags
}
