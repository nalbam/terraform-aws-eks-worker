# worker iam

resource "aws_iam_instance_profile" "worker" {
  name = local.worker_name
  role = var.role_name
}

data "aws_iam_role" "worker" {
  name = var.role_name
}
