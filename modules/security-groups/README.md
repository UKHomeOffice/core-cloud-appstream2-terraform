<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.appstream_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.allow_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.allow_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appstream_security_group"></a> [appstream\_security\_group](#input\_appstream\_security\_group) | Name of the AppStream security group | `string` | n/a | yes |
| <a name="input_appstream_vpc_id"></a> [appstream\_vpc\_id](#input\_appstream\_vpc\_id) | VPC ID where the security group will be created | `string` | n/a | yes |
| <a name="input_egress_cidr_blocks"></a> [egress\_cidr\_blocks](#input\_egress\_cidr\_blocks) | List of IPv4 CIDR blocks to allow outbound | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_egress_protocol"></a> [egress\_protocol](#input\_egress\_protocol) | IP protocol for egress (use "-1" for all) | `string` | `"-1"` | no |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | List of IPv4 CIDR blocks to allow inbound | `list(string)` | `[]` | no |
| <a name="input_ingress_from_port"></a> [ingress\_from\_port](#input\_ingress\_from\_port) | Start port for ingress rules | `number` | `443` | no |
| <a name="input_ingress_protocol"></a> [ingress\_protocol](#input\_ingress\_protocol) | IP protocol for ingress (e.g. "tcp") | `string` | `"tcp"` | no |
| <a name="input_ingress_to_port"></a> [ingress\_to\_port](#input\_ingress\_to\_port) | End port for ingress rules | `number` | `443` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_appstream_security_group_id"></a> [appstream\_security\_group\_id](#output\_appstream\_security\_group\_id) | ID of the AppStream security group |
<!-- END_TF_DOCS -->