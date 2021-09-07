# launch_template

resource "aws_launch_template" "worker_spot" {
  count = var.enable_spot ? 1 : 0

  name_prefix = format("%s-spot-", local.worker_name)

  image_id      = local.ami_id
  instance_type = local.instance_types.0

  user_data = base64encode(local.user_data)

  ebs_optimized = var.ebs_optimized
  key_name      = var.key_name

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_type           = var.volume_type
      volume_size           = var.volume_size
      delete_on_termination = true
    }
  }

  monitoring {
    enabled = var.enable_monitoring
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.worker.name
  }

  network_interfaces {
    delete_on_termination       = true
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = var.security_groups
  }

  instance_market_options {
    market_type = "spot"
  }

  tag_specifications {
    resource_type = "instance"

    tags = local.tags
  }

  tag_specifications {
    resource_type = "volume"

    tags = local.tags
  }

  tags = local.tags
}
