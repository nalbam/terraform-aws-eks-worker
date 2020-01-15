# eks

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-mz-seoul"
    key    = "eks-demo-worker.tfstate"
    # encrypt        = true
    # dynamodb_table = "terraform-resource-lock"
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

module "worker" {
  source = "../../"

  region = var.region
  name   = var.name

  cluster_name                  = data.terraform_remote_state.eks.outputs.name
  cluster_endpoint              = data.terraform_remote_state.eks.outputs.endpoint
  cluster_certificate_authority = data.terraform_remote_state.eks.outputs.certificate_authority
  cluster_security_group_id     = data.terraform_remote_state.eks.outputs.security_group_id
  kubernetes_version            = data.terraform_remote_state.eks.outputs.version

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  subnet_ids = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  subnet_azs = data.terraform_remote_state.vpc.outputs.public_subnet_azs

  allow_ip_address = var.allow_ip_address

  launch_configuration_enable = var.launch_configuration_enable
  launch_template_enable      = var.launch_template_enable
  launch_each_subnet          = var.launch_each_subnet

  associate_public_ip_address = var.associate_public_ip_address

  instance_type   = var.instance_type
  mixed_instances = var.mixed_instances

  volume_type = var.volume_type
  volume_size = var.volume_size

  min = var.min
  max = var.max

  on_demand_base = var.on_demand_base
  on_demand_rate = var.on_demand_rate

  key_name = var.key_name
  key_path = var.key_path
}
