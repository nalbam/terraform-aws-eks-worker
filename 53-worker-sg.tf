# worker security group

resource "aws_security_group" "worker" {
  name        = "${var.config.name}-cluster"
  description = "Cluster communication with worker nodes"

  vpc_id = var.config.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"                                             = "${var.config.name}-cluster"
    "KubernetesCluster"                                = var.config.cluster_name
    "kubernetes.io/cluster/${var.config.cluster_name}" = "owned"
  }
}

resource "aws_security_group_rule" "cluster-worker" {
  description              = "Allow worker to communicate with the cluster API Server"
  security_group_id        = var.config.cluster_security_group_id
  source_security_group_id = aws_security_group.worker.id
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  security_group_id        = aws_security_group.worker.id
  source_security_group_id = var.config.cluster_security_group_id
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker-worker" {
  description              = "Allow worker to communicate with each other"
  security_group_id        = aws_security_group.worker.id
  source_security_group_id = aws_security_group.worker.id
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker-ssh" {
  description       = "Allow workstation to communicate with the cluster API Server"
  security_group_id = aws_security_group.worker.id
  cidr_blocks       = var.config.allow_ip_address
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  type              = "ingress"
}
