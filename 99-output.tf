# output

output "worker_name" {
  value = local.worker_name
}

output "worker_ami_keyword" {
  value = local.worker_ami_keyword
}

output "worker_asg_id" {
  value = compact(concat(aws_autoscaling_group.worker.*.id, aws_autoscaling_group.worker-mixed.*.id))
}
