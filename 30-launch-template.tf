# launch_template

resource "aws_launch_template" "worker" {
  count = var.enable_spot ? 0 : 1

  name_prefix = format("%s-", local.worker_name)

  image_id      = local.ami_id
  instance_type = local.instance_types[0]

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
    name = local.instance_profile_name
  }

  network_interfaces {
    delete_on_termination       = true
    ipv6_address_count          = var.ipv6_address_count
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = var.security_groups
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
