# worker for single

resource "aws_autoscaling_group" "worker" {
  name_prefix = format("%s-", local.worker_name)

  min_size = var.min
  max_size = var.max

  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = var.target_group_arns

  capacity_rebalance    = var.capacity_rebalance
  protect_from_scale_in = var.protect_from_scale_in
  suspended_processes   = var.suspended_processes
  termination_policies  = var.termination_policies

  dynamic "launch_template" {
    for_each = local.launch_template
    content {
      id      = launch_template.value["template_id"]
      version = "$Latest"
    }
  }

  dynamic "mixed_instances_policy" {
    for_each = local.mixed_instances_policy
    content {
      instances_distribution {
        on_demand_base_capacity                  = mixed_instances_policy.value["on_demand_base"]
        on_demand_percentage_above_base_capacity = mixed_instances_policy.value["on_demand_rate"]
        spot_allocation_strategy                 = mixed_instances_policy.value["spot_strategy"]
      }

      launch_template {
        launch_template_specification {
          launch_template_id = mixed_instances_policy.value["template_id"]
          version            = "$Latest"
        }

        dynamic "override" {
          for_each = local.instance_types
          content {
            instance_type = override.value
          }
        }
      }
    }
  }

  enabled_metrics = var.enabled_metrics

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }

  dynamic "tag" {
    for_each = local.eks_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
