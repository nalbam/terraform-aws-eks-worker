# # worker iam role

# resource "aws_iam_role" "asg" {
#   name = "${var.name}-asg"

#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     },
#     {
#       "Sid": "",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "${module.worker.iam_role_arn}"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# POLICY

# }

# resource "aws_iam_role_policy_attachment" "asg" {
#   role       = aws_iam_role.asg.name
#   policy_arn = aws_iam_policy.asg.arn
# }

# resource "aws_iam_policy" "asg" {
#   name        = "${module.worker.iam_role_name}-asg"
#   description = "Autoscaling policy for ${var.cluster_name}"
#   policy      = data.aws_iam_policy_document.asg.json
#   path        = "/"
# }

# data "aws_iam_policy_document" "asg" {
#   statement {
#     sid    = "eksWorkerAutoscalingAll"
#     effect = "Allow"
#     actions = [
#       "autoscaling:DescribeAutoScalingGroups",
#       "autoscaling:DescribeAutoScalingInstances",
#       "autoscaling:DescribeLaunchConfigurations",
#       "autoscaling:DescribeTags",
#       "ec2:DescribeLaunchTemplateVersions",
#     ]
#     resources = ["*"]
#   }

#   statement {
#     sid    = "eksWorkerAutoscalingOwn"
#     effect = "Allow"
#     actions = [
#       "autoscaling:SetDesiredCapacity",
#       "autoscaling:TerminateInstanceInAutoScalingGroup",
#       "autoscaling:UpdateAutoScalingGroup",
#     ]
#     resources = ["*"]

#     condition {
#       test     = "StringEquals"
#       variable = "autoscaling:ResourceTag/kubernetes.io/cluster/${var.cluster_name}"
#       values   = ["owned"]
#     }

#     condition {
#       test     = "StringEquals"
#       variable = "autoscaling:ResourceTag/k8s.io/cluster-autoscaler/enabled"
#       values   = ["true"]
#     }
#   }
# }
