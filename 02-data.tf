# data

data "aws_ami" "worker" {
  count = var.ami_id == "" ? 1 : 0

  filter {
    name   = "name"
    values = [local.ami_keyword]
  }

  owners = ["602401143452"] # Amazon Account ID

  most_recent = true
}
