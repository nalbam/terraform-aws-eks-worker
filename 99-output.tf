# output

output "worker_name" {
  value = local.worker_name
}

output "worker_asg_id" {
  value = aws_autoscaling_group.worker.id
}

output "worker_lt_id" {
  value = aws_launch_template.worker.id
}
