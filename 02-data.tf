# data

data "aws_caller_identity" "current" {
}

data "aws_ami" "worker" {
  filter {
    name   = "name"
    values = [local.worker_ami_keyword]
  }

  owners = ["602401143452"] # Amazon Account ID

  most_recent = true
}

data "aws_ssm_parameter" "docker_config" {
  name = format("/k8s/common/%s", "docker-config")
}
