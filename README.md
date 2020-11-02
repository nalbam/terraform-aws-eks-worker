# terraform-aws-eks-worker

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_ip\_address | List of IP Address to permit access | `list(string)` | `[]` | no |
| ami\_id | n/a | `string` | `""` | no |
| associate\_public\_ip\_address | n/a | `bool` | `false` | no |
| autoscale\_enable | n/a | `bool` | `true` | no |
| cluster\_name | Name of the cluster, e.g: eks-demo | `any` | n/a | yes |
| instance\_type | n/a | `string` | `"m5.large"` | no |
| key\_name | n/a | `string` | `""` | no |
| key\_path | n/a | `string` | `""` | no |
| launch\_configuration\_enable | n/a | `bool` | `true` | no |
| launch\_each\_subnet | n/a | `bool` | `false` | no |
| launch\_template\_enable | n/a | `bool` | `false` | no |
| max | n/a | `string` | `"5"` | no |
| min | n/a | `string` | `"1"` | no |
| mixed\_instances | n/a | `list(string)` | `[]` | no |
| name | Name of the worker, e.g: worker | `any` | n/a | yes |
| node\_labels | n/a | `string` | `""` | no |
| node\_taints | n/a | `string` | `""` | no |
| on\_demand\_base | n/a | `string` | `"1"` | no |
| on\_demand\_rate | n/a | `string` | `"30"` | no |
| region | The region to deploy the cluster in, e.g: us-east-1 | `any` | n/a | yes |
| subnet\_ids | n/a | `list(string)` | `[]` | no |
| tags | n/a | `map(string)` | `{}` | no |
| volume\_size | n/a | `string` | `"32"` | no |
| volume\_type | n/a | `string` | `"gp2"` | no |
| vpc\_id | n/a | `string` | `""` | no |
| worker\_ami\_id | n/a | `string` | `""` | no |
| worker\_role\_name | n/a | `string` | `""` | no |
| worker\_security\_groups | n/a | `list(string)` | `[]` | no |
| worker\_target\_group\_arns | n/a | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_autoscaling\_group\_ids | n/a |
| aws\_launch\_configuration\_ids | n/a |
| aws\_launch\_template\_ids | n/a |
| name | n/a |
