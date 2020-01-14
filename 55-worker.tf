# worker

module "worker" {
  source = "github.com/nalbam/terraform-aws-asg?ref=v0.12.17"
  # source = "../terraform-aws-asg"

  name = var.config.name

  vpc_id = var.config.vpc_id

  subnet_ids = var.config.subnet_ids
  subnet_azs = var.config.subnet_azs

  launch_configuration_enable = var.config.launch_configuration_enable
  launch_template_enable      = var.config.launch_template_enable
  launch_each_subnet          = var.config.launch_each_subnet

  associate_public_ip_address = var.config.associate_public_ip_address

  ami_id = data.aws_ami.worker.id

  instance_type = var.config.instance_type

  mixed_instances = var.config.mixed_instances

  user_data = local.user_data

  volume_type = var.config.volume_type
  volume_size = var.config.volume_size

  min = var.config.min
  max = var.config.max

  on_demand_base = var.config.on_demand_base
  on_demand_rate = var.config.on_demand_rate

  key_name = var.config.key_name
  key_path = var.config.key_path

  security_groups = [aws_security_group.worker.id]

  tags = [
    {
      key                 = "KubernetesCluster"
      value               = var.config.cluster_name
      propagate_at_launch = true
    },
    {
      key                 = "kubernetes.io/cluster/${var.config.cluster_name}"
      value               = "owned"
      propagate_at_launch = true
    },
    {
      key                 = "k8s.io/cluster-autoscaler/${var.config.cluster_name}"
      value               = "owned"
      propagate_at_launch = true
    },
    {
      key                 = "k8s.io/cluster-autoscaler/enabled"
      value               = "true"
      propagate_at_launch = true
    },
  ]
}
