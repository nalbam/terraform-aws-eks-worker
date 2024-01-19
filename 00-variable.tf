# variable

variable "region" {
  type = string
}

variable "account_id" {
  type = string
}

variable "name" {
  description = "Name of the worker. e.g: worker"
  type        = string
}

variable "subname" {
  description = "Subname of the worker, e.g: a"
  type        = string
  default     = ""
}

variable "vername" {
  description = "Version of the worker, e.g: v1"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "Name of the cluster, e.g: cluster"
  type        = string
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_certificate_authority" {
  type = string
}

variable "kubernetes_version" {
  description = "Version of the kubernetes, e.g: 1.28"
  type        = string
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "security_groups" {
  type    = list(string)
  default = []
}

variable "role_name" {
  type    = string
  default = ""
}

variable "instance_profile_name" {
  type    = string
  default = ""
}

variable "target_group_arns" {
  type    = list(string)
  default = []
}

variable "http_tokens" {
  type    = string
  default = "optional" # required
}

variable "ami_arch" {
  type    = string
  default = "x86_64" # arm64
}

variable "ami_keyword" {
  type    = string
  default = "*"
}

variable "ami_id" {
  type    = string
  default = ""
}

variable "instance_type" {
  type    = string
  default = ""
}

variable "mixed_instances" {
  type    = list(string)
  default = []
}

variable "ipv6_address_count" {
  type    = number
  default = 0
}

variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "enable_autoscale" {
  type    = bool
  default = true
}

variable "enable_event" {
  type    = bool
  default = true
}

variable "enable_monitoring" {
  type    = bool
  default = true
}

variable "enable_taints" {
  type    = bool
  default = false
}

variable "enabled_metrics" {
  type = list(string)
  default = [
    "GroupDesiredCapacity",
    "GroupInServiceCapacity",
    "GroupInServiceInstances",
    "GroupMaxSize",
    "GroupMinSize",
    "GroupPendingCapacity",
    "GroupPendingInstances",
    "GroupStandbyCapacity",
    "GroupStandbyInstances",
    "GroupTerminatingCapacity",
    "GroupTerminatingInstances",
    "GroupTotalCapacity",
    "GroupTotalInstances",
  ]
}

variable "ebs_optimized" {
  type    = bool
  default = true
}

variable "volume_type" {
  type    = string
  default = "gp3"
}

variable "volume_size" {
  type    = string
  default = "50"
}

variable "min" {
  type    = number
  default = 1
}

variable "max" {
  type    = number
  default = 6
}

variable "enable_spot" {
  type    = bool
  default = false
}

variable "enable_mixed" {
  type    = bool
  default = false
}

variable "capacity_rebalance" {
  type    = bool
  default = false
}

variable "protect_from_scale_in" {
  type    = bool
  default = false
}

variable "suspended_processes" {
  type = list(string)
  default = [
    # "AZRebalance",
  ]
}

variable "termination_policies" {
  type = list(string)
  default = [
    "Default",
  ]
}

variable "on_demand_base" {
  type    = number
  default = 2
}

variable "on_demand_rate" {
  type    = number
  default = 30
}

variable "spot_strategy" {
  type    = string
  default = "price-capacity-optimized"
  # lowest-price, capacity-optimized, capacity-optimized-prioritized, price-capacity-optimized
}

variable "log_levels" {
  type    = number
  default = 3
}

variable "key_name" {
  type    = string
  default = "eks_user"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "node_labels" {
  type    = map(string)
  default = {}
}

variable "additional_user_data" {
  type    = string
  default = ""
}

variable "additional_extra_args" {
  type    = string
  default = ""
}
