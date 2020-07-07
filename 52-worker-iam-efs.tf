# # worker iam role

# resource "aws_iam_role" "efs" {
#   name = "${var.name}-efs"

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

# resource "aws_iam_role_policy_attachment" "efs" {
#   role       = aws_iam_role.efs.name
#   policy_arn = aws_iam_policy.efs.arn
# }

# resource "aws_iam_policy" "efs" {
#   name        = "${module.worker.iam_role_name}-efs"
#   description = "EFS policy for ${var.cluster_name}"
#   policy      = data.aws_iam_policy_document.efs.json
#   path        = "/"
# }

# data "aws_iam_policy_document" "efs" {
#   statement {
#     sid    = "eksWorkerEFSAll"
#     effect = "Allow"
#     actions = [
#       "efs:*",
#     ]
#     resources = [
#       "arn:aws:efs:::*",
#     ]
#   }
# }
