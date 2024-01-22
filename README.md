# terraform-aws-eks-worker

[![build](https://img.shields.io/github/actions/workflow/status/nalbam/terraform-aws-eks-worker/push.yml?branch=main&style=for-the-badge&logo=github)](https://github.com/nalbam/terraform-aws-eks-worker/actions/workflows/push.yml)
[![release](https://img.shields.io/github/v/release/nalbam/terraform-aws-eks-worker?style=for-the-badge&logo=github)](https://github.com/nalbam/terraform-aws-eks-worker/releases)

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5 |
| aws | >= 5.1.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 5.1.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | n/a | `string` | n/a | yes |
| additional\_extra\_args | n/a | `string` | `""` | no |
| additional\_user\_data | n/a | `string` | `""` | no |
| ami\_arch | n/a | `string` | `"x86_64"` | no |
| ami\_id | n/a | `string` | `""` | no |
| ami\_keyword | n/a | `string` | `"*"` | no |
| associate\_public\_ip\_address | n/a | `bool` | `false` | no |
| capacity\_rebalance | n/a | `bool` | `false` | no |
| cluster\_certificate\_authority | n/a | `string` | n/a | yes |
| cluster\_endpoint | n/a | `string` | n/a | yes |
| cluster\_name | Name of the cluster, e.g: cluster | `string` | n/a | yes |
| ebs\_optimized | n/a | `bool` | `true` | no |
| enable\_autoscale | n/a | `bool` | `true` | no |
| enable\_event | n/a | `bool` | `true` | no |
| enable\_mixed | n/a | `bool` | `false` | no |
| enable\_monitoring | n/a | `bool` | `true` | no |
| enable\_spot | n/a | `bool` | `false` | no |
| enable\_taints | n/a | `bool` | `false` | no |
| enabled\_metrics | n/a | `list(string)` | <pre>[<br>  "GroupDesiredCapacity",<br>  "GroupInServiceCapacity",<br>  "GroupInServiceInstances",<br>  "GroupMaxSize",<br>  "GroupMinSize",<br>  "GroupPendingCapacity",<br>  "GroupPendingInstances",<br>  "GroupStandbyCapacity",<br>  "GroupStandbyInstances",<br>  "GroupTerminatingCapacity",<br>  "GroupTerminatingInstances",<br>  "GroupTotalCapacity",<br>  "GroupTotalInstances"<br>]</pre> | no |
| http\_tokens | n/a | `string` | `"required"` | no |
| instance\_profile\_name | n/a | `string` | `""` | no |
| instance\_type | n/a | `string` | `""` | no |
| ipv6\_address\_count | n/a | `number` | `0` | no |
| key\_name | n/a | `string` | `"eks_user"` | no |
| kubernetes\_version | Version of the kubernetes, e.g: 1.28 | `string` | n/a | yes |
| log\_levels | n/a | `number` | `3` | no |
| max | n/a | `number` | `6` | no |
| min | n/a | `number` | `1` | no |
| mixed\_instances | n/a | `list(string)` | `[]` | no |
| name | Name of the worker. e.g: worker | `string` | n/a | yes |
| node\_labels | n/a | `map(string)` | `{}` | no |
| on\_demand\_base | n/a | `number` | `2` | no |
| on\_demand\_rate | n/a | `number` | `30` | no |
| protect\_from\_scale\_in | n/a | `bool` | `false` | no |
| region | n/a | `string` | n/a | yes |
| role\_name | n/a | `string` | `""` | no |
| security\_groups | n/a | `list(string)` | `[]` | no |
| spot\_strategy | n/a | `string` | `"price-capacity-optimized"` | no |
| subname | Subname of the worker, e.g: a | `string` | `""` | no |
| subnet\_ids | n/a | `list(string)` | `[]` | no |
| suspended\_processes | n/a | `list(string)` | `[]` | no |
| tags | n/a | `map(string)` | `{}` | no |
| target\_group\_arns | n/a | `list(string)` | `[]` | no |
| termination\_policies | n/a | `list(string)` | <pre>[<br>  "Default"<br>]</pre> | no |
| vername | Version of the worker, e.g: v1 | `string` | `""` | no |
| volume\_size | n/a | `string` | `"50"` | no |
| volume\_type | n/a | `string` | `"gp3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| worker\_asg\_id | n/a |
| worker\_lt\_id | n/a |
| worker\_name | n/a |

<!--- END_TF_DOCS --->
