# data

data "aws_caller_identity" "current" {
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.aws_eks_cluster.cluster.name
}

data "aws_ami" "worker" {
  filter {
    name   = "name"
    values = [local.worker_ami_prefix]
  }

  owners = ["602401143452"] # Amazon Account ID

  most_recent = true
}
