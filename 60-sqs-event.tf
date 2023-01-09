# sqs

data "aws_sqs_queue" "nth" {
  count = var.enable_event ? 1 : 0

  name = format("%s-worker", local.cluster_name)
}

# EC2 Instance-terminate Lifecycle Action

resource "aws_cloudwatch_event_rule" "nth_asg" {
  count = var.enable_event ? 1 : 0

  name        = format("%s-asg-termination", local.worker_name)
  description = "EC2 Instance-terminate Lifecycle Action"
  event_pattern = jsonencode(
    {
      "source" : [
        "aws.autoscaling"
      ]
      "detail-type" : [
        "EC2 Instance-terminate Lifecycle Action"
      ]
      "resources" : local.worker_asg_arns
    }
  )
}

resource "aws_cloudwatch_event_target" "nth_asg" {
  count = var.enable_event ? 1 : 0

  target_id = format("%s-asg-termination", local.worker_name)
  rule      = aws_cloudwatch_event_rule.nth_asg.0.name
  arn       = data.aws_sqs_queue.nth.0.arn
}

# EC2_INSTANCE_TERMINATING

resource "aws_autoscaling_lifecycle_hook" "nth" {
  count = var.enable_event ? 1 : 0

  name                   = "aws-node-termination-handler"
  autoscaling_group_name = var.enable_mixed ? aws_autoscaling_group.worker_mixed.0.name : aws_autoscaling_group.worker.0.name
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  heartbeat_timeout      = 300
  default_result         = "CONTINUE"

  # notification_target_arn = data.aws_sqs_queue.nth.0.arn
  # role_arn                = ""
}
