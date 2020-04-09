# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "name" {
  description = "Name of the worker, e.g: eks-demo-worker"
}

variable "cluster_name" {
  description = "Name of the cluster, e.g: eks-demo"
}

variable "cluster_endpoint" {
}

variable "cluster_certificate_authority" {
}

variable "cluster_security_group_id" {
}

variable "kubernetes_version" {
  default = "1.14"
}

variable "vpc_id" {
  default = ""
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "subnet_azs" {
  type    = list(string)
  default = []
}

variable "allow_ip_address" {
  description = "List of IP Address to permit access"
  type        = list(string)
  default     = []
}

variable "launch_configuration_enable" {
  default = true
}

variable "launch_template_enable" {
  default = false
}

variable "launch_each_subnet" {
  default = false
}

variable "associate_public_ip_address" {
  default = false
}

variable "ami_id" {
  default = ""
}

variable "instance_type" {
  default = "m5.large"
}

variable "mixed_instances" {
  type    = list(string)
  default = []
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {
  default = "32"
}

variable "min" {
  default = "1"
}

variable "max" {
  default = "5"
}

variable "on_demand_base" {
  default = "1"
}

variable "on_demand_rate" {
  default = "30"
}

variable "key_name" {
  default = ""
}

variable "key_path" {
  default = ""
}

variable "tags" {
  type = list(object({
    key                 = string
    value               = string
    propagate_at_launch = bool
  }))
  default = []
}
