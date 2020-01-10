# variable

data "aws_caller_identity" "current" {
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    region = "ap-northeast-2"
    bucket = "terraform-mz-seoul"
    key    = "vpc-demo.tfstate"
  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    region = "ap-northeast-2"
    bucket = "terraform-mz-seoul"
    key    = "eks-demo.tfstate"
  }
}

variable "region" {
  default = "ap-northeast-2"
}

variable "name" {
  default = "seoul-dev-demo-eks-worker"
}

variable "allow_ip_address" {
  default = [
    "10.10.1.0/24", # bastion
  ]
}

variable "launch_configuration_enable" {
  default = false
}

variable "launch_template_enable" {
  default = true
}

variable "launch_each_subnet" {
  default = false
}

variable "associate_public_ip_address" {
  default = true
}

variable "instance_type" {
  default = "m5.large"
}

variable "mixed_instances" {
  default = ["c5.large", "r5.large"]
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {
  default = "32"
}

variable "min" {
  default = "2"
}

variable "max" {
  default = "5"
}

variable "on_demand_base" {
  default = "0"
}

variable "on_demand_rate" {
  default = "0"
}

variable "key_name" {
  default = "nalbam-seoul"
}

variable "key_path" {
  default = ""
}
