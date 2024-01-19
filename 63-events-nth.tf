# sqs

locals {
  sqs_nth_name = format("%s-nth", var.cluster_name)

  sqs_nth_arn = format("arn:aws:sqs:%s:%s:%s", var.region, var.account_id, local.sqs_nth_name)

  event_rule_name = format("%s-%s", local.sqs_nth_name, local.fullname)
}

# EC2 Instance-terminate Lifecycle Action

resource "aws_cloudwatch_event_rule" "nth_asg" {
  count = var.enable_event ? 1 : 0

  name        = format("%s-asg-termination", local.event_rule_name)
  description = "EC2 Instance-terminate Lifecycle Action"

  event_pattern = jsonencode(
    {
      "source" : [
        "aws.autoscaling"
      ]
      "detail-type" : [
        "EC2 Instance-terminate Lifecycle Action"
      ]
      "resources" : [aws_autoscaling_group.worker.arn]
    }
  )

  tags = merge(
    local.tags,
    {
      "Name" = format("%s-asg-termination", local.event_rule_name)
    },
  )
}

resource "aws_cloudwatch_event_target" "nth_asg" {
  count = var.enable_event ? 1 : 0

  target_id = format("%s-asg-termination", local.event_rule_name)
  rule      = aws_cloudwatch_event_rule.nth_asg.0.name
  arn       = local.sqs_nth_arn
}

# EC2_INSTANCE_TERMINATING

resource "aws_autoscaling_lifecycle_hook" "nth" {
  count = var.enable_event ? 1 : 0

  name                   = "aws-node-termination-handler"
  autoscaling_group_name = aws_autoscaling_group.worker.name
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  heartbeat_timeout      = 300
  default_result         = "CONTINUE"

  # notification_target_arn = local.sqs_nth_arn
  # role_arn                = ""
}
