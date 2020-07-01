# worker

module "worker" {
  source = "github.com/nalbam/terraform-aws-asg?ref=v0.12.23"
  # source = "../terraform-aws-asg"

  name = var.name

  vpc_id = var.vpc_id

  subnet_ids = var.subnet_ids
  subnet_azs = var.subnet_azs

  launch_configuration_enable = var.launch_configuration_enable
  launch_template_enable      = var.launch_template_enable
  launch_each_subnet          = var.launch_each_subnet

  associate_public_ip_address = var.associate_public_ip_address

  ami_id = data.aws_ami.worker.id

  instance_type   = var.instance_type
  mixed_instances = var.mixed_instances

  user_data = local.user_data

  volume_type = var.volume_type
  volume_size = var.volume_size

  min = var.min
  max = var.max

  on_demand_base = var.on_demand_base
  on_demand_rate = var.on_demand_rate

  key_name = var.key_name
  key_path = var.key_path

  security_groups = [aws_security_group.worker.id]

  tags = local.tags
}
