# output

output "iam_role_arn" {
  value = module.worker.iam_role_arn
}

output "iam_role_name" {
  value = module.worker.iam_role_name
}

output "security_group_id" {
  value = module.worker.security_group_id
}
