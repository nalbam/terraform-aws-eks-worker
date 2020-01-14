# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "config" {
  type = object({
    name = string

    cluster_name                  = string
    cluster_endpoint              = string
    cluster_certificate_authority = string
    cluster_security_group_id     = string
    kubernetes_version            = string

    subnet_ids = list(string)
    subnet_azs = list(string)

    vpc_id = string

    allow_ip_address = list(string)

    launch_configuration_enable = bool
    launch_template_enable      = bool

    launch_each_subnet          = bool
    associate_public_ip_address = bool

    instance_type   = string
    mixed_instances = list(string)

    volume_type = string
    volume_size = string

    min = string
    max = string

    on_demand_base = string
    on_demand_rate = string

    key_name = string
    key_path = string
  })
  # default = {
  #   kubernetes_version = "1.14"

  #   allow_ip_address = []

  #   launch_configuration_enable = false
  #   launch_template_enable      = false

  #   launch_each_subnet          = false
  #   associate_public_ip_address = false

  #   instance_type   = "m5.large"
  #   mixed_instances = []

  #   volume_type = "gp2"
  #   volume_size = "32"

  #   min = "1"
  #   max = "5"

  #   on_demand_base = "1"
  #   on_demand_rate = "30"

  #   key_name = ""
  #   key_path = ""
  # }
}

# variable "name" {
#   description = "Name of the worker, e.g: seoul-dev-demo-eks-worker"
# }

# variable "cluster_name" {
#   description = "Name of the cluster, e.g: seoul-dev-demo-eks"
# }

# variable "cluster_endpoint" {
# }

# variable "cluster_certificate_authority" {
# }

# variable "cluster_security_group_id" {
# }

# variable "kubernetes_version" {
#   default = "1.14"
# }

# variable "vpc_id" {
#   default = ""
# }

# variable "subnet_ids" {
#   type    = list(string)
#   default = []
# }

# variable "subnet_azs" {
#   type    = list(string)
#   default = []
# }

# variable "allow_ip_address" {
#   description = "List of IP Address to permit access"
#   type        = list(string)
#   default     = []
# }

# variable "launch_configuration_enable" {
#   default = true
# }

# variable "launch_template_enable" {
#   default = false
# }

# variable "launch_each_subnet" {
#   default = false
# }

# variable "associate_public_ip_address" {
#   default = false
# }

# variable "ami_id" {
#   default = ""
# }

# variable "instance_type" {
#   default = "m5.large"
# }

# variable "mixed_instances" {
#   type    = list(string)
#   default = []
# }

# variable "volume_type" {
#   default = "gp2"
# }

# variable "volume_size" {
#   default = "32"
# }

# variable "min" {
#   default = "1"
# }

# variable "max" {
#   default = "5"
# }

# variable "on_demand_base" {
#   default = "1"
# }

# variable "on_demand_rate" {
#   default = "30"
# }

# variable "key_name" {
#   default = ""
# }

# variable "key_path" {
#   default = ""
# }
