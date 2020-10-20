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
    values = ["amazon-eks-node-${data.aws_eks_cluster.cluster.version}-*"]
  }

  owners = ["602401143452"] # Amazon Account ID

  most_recent = true
}
