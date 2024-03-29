# launch_template

resource "aws_launch_template" "worker" {
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

  dynamic "instance_market_options" {
    for_each = local.instance_market_options
    content {
      market_type = instance_market_options.value["market_type"]
    }
  }

  iam_instance_profile {
    name = local.instance_profile_name
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = var.http_tokens
    http_put_response_hop_limit = 1
  }

  monitoring {
    enabled = var.enable_monitoring
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
