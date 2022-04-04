# terraform-aws-eks-worker

[![build](https://img.shields.io/github/workflow/status/nalbam/terraform-aws-eks-worker/build?label=build&style=for-the-badge&logo=github)](https://github.com/nalbam/terraform-aws-eks-worker/actions/workflows/push.yaml)
[![release](https://img.shields.io/github/v/release/nalbam/terraform-aws-eks-worker?style=for-the-badge&logo=github)](https://github.com/nalbam/terraform-aws-eks-worker/releases)

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.30.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.30.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami\_id | n/a | `string` | `""` | no |
| associate\_public\_ip\_address | n/a | `bool` | `false` | no |
| cluster\_info | Map of the cluster. | `map(string)` | n/a | yes |
| ebs\_optimized | n/a | `bool` | `true` | no |
| enable\_autoscale | n/a | `bool` | `true` | no |
| enable\_event | n/a | `bool` | `false` | no |
| enable\_mixed | n/a | `bool` | `false` | no |
| enable\_monitoring | n/a | `bool` | `true` | no |
| enable\_spot | n/a | `bool` | `false` | no |
| enable\_taints | n/a | `bool` | `false` | no |
| enabled\_metrics | n/a | `list` | <pre>[<br>  "GroupDesiredCapacity",<br>  "GroupInServiceCapacity",<br>  "GroupInServiceInstances",<br>  "GroupMaxSize",<br>  "GroupMinSize",<br>  "GroupPendingCapacity",<br>  "GroupPendingInstances",<br>  "GroupStandbyCapacity",<br>  "GroupStandbyInstances",<br>  "GroupTerminatingCapacity",<br>  "GroupTerminatingInstances",<br>  "GroupTotalCapacity",<br>  "GroupTotalInstances"<br>]</pre> | no |
| instance\_profile\_name | n/a | `string` | `""` | no |
| instance\_type | n/a | `string` | `""` | no |
| ipv6\_address\_count | n/a | `number` | `0` | no |
| key\_name | n/a | `string` | `"eks_user"` | no |
| log\_levels | n/a | `number` | `3` | no |
| max | n/a | `number` | `5` | no |
| min | n/a | `number` | `1` | no |
| mixed\_instances | n/a | `list(string)` | `[]` | no |
| name | Name of the worker. e.g: worker | `string` | n/a | yes |
| node\_labels | n/a | `map(string)` | `{}` | no |
| on\_demand\_base | n/a | `number` | `1` | no |
| on\_demand\_rate | n/a | `number` | `30` | no |
| role\_name | n/a | `string` | `""` | no |
| security\_groups | n/a | `list(string)` | `[]` | no |
| subname | Subname of the worker, e.g: a | `string` | `""` | no |
| subnet\_ids | n/a | `list(string)` | `[]` | no |
| tags | n/a | `map(string)` | `{}` | no |
| target\_group\_arns | n/a | `list(string)` | `[]` | no |
| vername | Version of the worker, e.g: v1 | `string` | `""` | no |
| volume\_size | n/a | `string` | `"50"` | no |
| volume\_type | n/a | `string` | `"gp2"` | no |
| worker\_ami\_arch | n/a | `string` | `"x86_64"` | no |
| worker\_ami\_keyword | n/a | `string` | `"*"` | no |

## Outputs

| Name | Description |
|------|-------------|
| worker\_ami\_keyword | n/a |
| worker\_asg\_ids | n/a |
| worker\_lt\_ids | n/a |
| worker\_name | n/a |

<!--- END_TF_DOCS --->
