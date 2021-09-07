# worker for mixed

resource "aws_autoscaling_group" "worker-mixed" {
  count = var.enable_managed_nodegroup ? 0 : length(local.instance_types) > 1 ? 1 : 0

  name_prefix = format("%s-%s-", local.worker_name, "mixed")

  min_size = var.min
  max_size = var.max

  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = var.target_group_arns

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = var.on_demand_base
      on_demand_percentage_above_base_capacity = var.on_demand_rate
      spot_allocation_strategy                 = "capacity-optimized"
    }

    launch_template {
      launch_template_specification {
        launch_template_id = var.enable_spot ? aws_launch_template.worker_spot[0].id : aws_launch_template.worker[0].id
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

  enabled_metrics = var.enabled_metrics

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }

  tags = local.asg_tags
}
