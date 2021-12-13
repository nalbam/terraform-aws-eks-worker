# sqs

data "aws_sqs_queue" "nth" {
  count = var.enable_event ? 1 : 0

  name = format("%s-worker", local.cluster_name)
}

resource "aws_cloudwatch_event_rule" "nth_asg" {
  count = var.enable_event ? 1 : 0

  name        = format("%s-asg-termination", local.worker_name)
  description = "Node termination event rule"
  event_pattern = jsonencode(
    {
      "source" : [
        "aws.autoscaling"
      ],
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

resource "aws_cloudwatch_event_rule" "nth_spot" {
  count = var.enable_event ? 1 : 0

  name        = format("%s-spot-termination", local.worker_name)
  description = "Node termination event rule"
  event_pattern = jsonencode(
    {
      "source" : [
        "aws.ec2"
      ],
      "detail-type" : [
        "EC2 Spot Instance Interruption Warning"
      ]
      "resources" : local.worker_asg_arns
    }
  )
}

resource "aws_cloudwatch_event_target" "nth_spot" {
  count = var.enable_event ? 1 : 0

  target_id = format("%s-spot-termination", local.worker_name)
  rule      = aws_cloudwatch_event_rule.nth_spot.0.name
  arn       = data.aws_sqs_queue.nth.0.arn
}
