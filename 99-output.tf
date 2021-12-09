# output

output "worker_name" {
  value = local.worker_name
}

output "worker_ami_keyword" {
  value = local.worker_ami_keyword
}

output "worker_asg_id" {
  value = compact(concat(
    aws_autoscaling_group.worker.*.id,
    aws_autoscaling_group.worker_mixed.*.id,
  ))
}

output "worker_lt_id" {
  value = compact(concat(
    aws_launch_template.worker.*.id,
    aws_launch_template.worker_spot.*.id,
  ))
}
