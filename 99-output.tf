# output

output "name" {
  value = local.name
}

# output "iam_role_arn" {
#   value = module.worker.iam_role_arn
# }

# output "iam_role_name" {
#   value = module.worker.iam_role_name
# }

# output "security_group_id" {
#   value = module.worker.security_group_id
# }

output "aws_launch_configuration_ids" {
  value = module.worker.aws_launch_configuration_ids
}

output "aws_launch_template_ids" {
  value = module.worker.aws_launch_template_ids
}

output "aws_autoscaling_group_ids" {
  value = module.worker.aws_autoscaling_group_ids
}
