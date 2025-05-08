# Terraform AWS AppStream2
A Terraform module to provision AWS AppStream 2.0 fleets and associated stacks, including autoscaling policies, CloudWatch alarms, and optional HOMEFOLDER storage connectors.

## Terraform Example
```hcl
module "appstream2" {
  source  = "git::https://github.com/UKHomeOffice/core-cloud-appstream2-terraform.git//modules/appstream2?ref=0.1.0"

  region                             = var.region
  desired_instances                  = var.desired_instances
  instance_type                      = var.instance_type
  description                        = var.description
  display_name                       = var.display_name
  idle_disconnect_timeout_in_seconds = var.idle_disconnect_timeout_in_seconds
  disconnect_timeout_in_seconds      = var.disconnect_timeout_in_seconds
  enable_default_internet_access     = var.enable_default_internet_access
  fleet_type                         = var.fleet_type
  max_user_duration_in_seconds       = var.max_user_duration_in_seconds

  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids

  stack_name         = var.stack_name
  stack_description  = var.stack_description
  stack_display_name = var.stack_display_name
  enable_homefolder  = var.enable_homefolder

  fleet_configs = var.fleet_configs
  associated_fleet = var.associated_fleet

  scale_out_metric_interval_upper_bound = var.scale_out_metric_interval_upper_bound
  scale_out_adjustment                  = var.scale_out_adjustment
  scale_in_metric_interval_upper_bound  = var.scale_in_metric_interval_upper_bound
  scale_in_adjustment                   = var.scale_in_adjustment

  user_settings = var.user_settings  # Optional overrides
}

```

## Terragrunt Example

```hcl
terraform {
  source = "git::https://github.com/UKHomeOffice/core-cloud-appstream2-terraform.git//modules/appstream2?ref=0.1.0"
}

dependency "security_groups" {
  config_path = "../security-groups"
}

inputs = {
  region                             = "eu-west-1"
  desired_instances                  = 2
  instance_type                      = "stream.standard.medium"
  description                        = "Terragrunt AppStream2 Fleet"
  display_name                       = "Terragrunt Fleet"
  idle_disconnect_timeout_in_seconds = 600
  disconnect_timeout_in_seconds      = 60
  enable_default_internet_access     = true
  fleet_type                         = "ON_DEMAND"
  max_user_duration_in_seconds       = 3600

  subnet_ids         = ["subnet-0123456789abcdef0"]
  security_group_ids = [dependency.security_groups.outputs.appstream_security_group_id]

  stack_name         = "tg-appstream-stack"
  stack_description  = "Terragrunt-managed Stack"
  stack_display_name = "Terragrunt Stack"
  enable_homefolder  = false

  fleet_configs = [
    {
      fleet_name      = "tg-fleet-1"
      image_arn       = "arn:aws:appstream:eu-west-1:123456789012:image/example"
      min_capacity    = 1
      max_capacity    = 5
      scale_up_cron   = "cron(0 8 ? * MON-FRI *)"
      scale_down_cron = "cron(0 18 ? * MON-FRI *)"
      min_wh_capacity = 1
      max_wh_capacity = 5
    }
  ]
  associated_fleet = "tg-fleet-1"

  scale_out_metric_interval_upper_bound = 0
  scale_out_adjustment                  = 50
  scale_in_metric_interval_upper_bound  = 0
  scale_in_adjustment                   = -50
}
```



<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.scale_in_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.scale_out_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_scheduled_action.appstream_scale_down](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_scheduled_action) | resource |
| [aws_appautoscaling_scheduled_action.appstream_scale_up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_scheduled_action) | resource |
| [aws_appautoscaling_target.appstream_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_appstream_fleet.appstream_fleet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appstream_fleet) | resource |
| [aws_appstream_fleet_stack_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appstream_fleet_stack_association) | resource |
| [aws_appstream_stack.appstream_stack](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appstream_stack) | resource |
| [aws_cloudwatch_metric_alarm.scale_in_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.scale_out_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [null_resource.create-appstream-usage-report](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.manage_homefolder](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.wait_for_fleet_running](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associated_fleet"></a> [associated\_fleet](#input\_associated\_fleet) | The fleet\_name from fleet\_configs to associate with the Stack | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (Optional) Description to display for the AppStream fleet | `string` | n/a | yes |
| <a name="input_desired_instances"></a> [desired\_instances](#input\_desired\_instances) | (Optional) Desired number of streaming instances | `number` | n/a | yes |
| <a name="input_disconnect_timeout_in_seconds"></a> [disconnect\_timeout\_in\_seconds](#input\_disconnect\_timeout\_in\_seconds) | (Optional) Amount of time that a streaming session remains active after users disconnect. | `number` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | (Optional) Human-readable friendly name for the AppStream fleet | `string` | n/a | yes |
| <a name="input_enable_default_internet_access"></a> [enable\_default\_internet\_access](#input\_enable\_default\_internet\_access) | (Optional) Enables or disables default internet access for the fleet. | `bool` | n/a | yes |
| <a name="input_enable_homefolder"></a> [enable\_homefolder](#input\_enable\_homefolder) | Enable or disable the HOMEFOLDER storage connector. | `bool` | n/a | yes |
| <a name="input_fleet_configs"></a> [fleet\_configs](#input\_fleet\_configs) | List of fleet-specific autoscaling configs | <pre>list(object({<br/>    fleet_name       = string<br/>    image_arn        = string<br/>    min_capacity     = number<br/>    max_capacity     = number<br/>    scale_up_cron    = string<br/>    scale_down_cron  = string<br/>    min_wh_capacity  = number<br/>    max_wh_capacity  = number<br/>  }))</pre> | n/a | yes |
| <a name="input_fleet_type"></a> [fleet\_type](#input\_fleet\_type) | (Optional) Fleet type. Valid values are: (e.g. "ALWAYS\_ON" or "ON\_DEMAND") | `string` | n/a | yes |
| <a name="input_idle_disconnect_timeout_in_seconds"></a> [idle\_disconnect\_timeout\_in\_seconds](#input\_idle\_disconnect\_timeout\_in\_seconds) | (Optional) Amount of time that users can be idle (inactive) before they are disconnected from their streaming session and the disconnect\_timeout\_in\_seconds time interval begins. Defaults to 0. Valid value is between 60 and 3600seconds. | `number` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | (Required) Instance type to use when launching fleet instances | `string` | n/a | yes |
| <a name="input_max_user_duration_in_seconds"></a> [max\_user\_duration\_in\_seconds](#input\_max\_user\_duration\_in\_seconds) | (Optional) Maximum amount of time that a streaming session can remain active, in seconds. | `number` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region in which to deploy AppStream resources | `string` | n/a | yes |
| <a name="input_scale_in_adjustment"></a> [scale\_in\_adjustment](#input\_scale\_in\_adjustment) | Percentage change in capacity for scale-in StepScaling policy | `number` | n/a | yes |
| <a name="input_scale_in_metric_interval_upper_bound"></a> [scale\_in\_metric\_interval\_upper\_bound](#input\_scale\_in\_metric\_interval\_upper\_bound) | Lower bound for triggering scale-in StepScaling policy (metric interval) | `number` | n/a | yes |
| <a name="input_scale_out_adjustment"></a> [scale\_out\_adjustment](#input\_scale\_out\_adjustment) | Percentage change in capacity for scale-out StepScaling policy | `number` | n/a | yes |
| <a name="input_scale_out_metric_interval_upper_bound"></a> [scale\_out\_metric\_interval\_upper\_bound](#input\_scale\_out\_metric\_interval\_upper\_bound) | Lower bound for triggering scale-out StepScaling policy (metric interval) | `number` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group IDs to attach to the fleet | `list(string)` | n/a | yes |
| <a name="input_stack_description"></a> [stack\_description](#input\_stack\_description) | (Optional) Description for the AppStream stack | `string` | n/a | yes |
| <a name="input_stack_display_name"></a> [stack\_display\_name](#input\_stack\_display\_name) | (Optional) Human-readable display name for the AppStream Stack | `string` | n/a | yes |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | (Required) Unique name for the AppStream stack. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs for the fleet’s VPC configuration | `list(string)` | n/a | yes |
| <a name="input_user_settings"></a> [user\_settings](#input\_user\_settings) | List of user settings for the Stack (action + permission) | <pre>list(object({<br/>    action     = string<br/>    permission = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "action": "CLIPBOARD_COPY_FROM_LOCAL_DEVICE",<br/>    "permission": "ENABLED"<br/>  },<br/>  {<br/>    "action": "CLIPBOARD_COPY_TO_LOCAL_DEVICE",<br/>    "permission": "DISABLED"<br/>  },<br/>  {<br/>    "action": "DOMAIN_PASSWORD_SIGNIN",<br/>    "permission": "ENABLED"<br/>  },<br/>  {<br/>    "action": "DOMAIN_SMART_CARD_SIGNIN",<br/>    "permission": "DISABLED"<br/>  },<br/>  {<br/>    "action": "FILE_DOWNLOAD",<br/>    "permission": "DISABLED"<br/>  },<br/>  {<br/>    "action": "FILE_UPLOAD",<br/>    "permission": "DISABLED"<br/>  },<br/>  {<br/>    "action": "PRINTING_TO_LOCAL_DEVICE",<br/>    "permission": "DISABLED"<br/>  }<br/>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->