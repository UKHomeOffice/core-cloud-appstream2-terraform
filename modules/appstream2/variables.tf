# Appstream Fleet
variable "desired_instances" {}
variable "description" {}
variable "idle_disconnect_timeout_in_seconds" {}
variable "disconnect_timeout_in_seconds" {}
variable "display_name" {}
variable "enable_default_internet_access" {}
variable "fleet_type" {}

// Fleet_config
variable "fleet_configs" {
  type = list(
    object({
      fleet_name       = string
      image_arn        = string
      min_capacity     = number
      max_capacity     = number
      scale_up_cron    = string
      scale_down_cron  = string
      min_wh_capacity  = number
      max_wh_capacity  = number
    })
  )
  description = "List of AppStream fleets and their configurations"
}
variable "associated_fleet" {
  type        = string
  description = "The name of the fleet which is currently associated with the stack."
}
variable "instance_type" {}
variable "max_user_duration_in_seconds" {}
variable "Environment" {}
variable "Project" {}
variable "subnet_id" {}
variable "security_group_ids" {}

# Appstream Stack
variable "stack_name" {}
variable "stack_description" {}
variable "stack_display_name" {}
variable "region" {}

variable "enable_homefolder" {
  description = "Enable or disable the HOMEFOLDER storage connector."
  type        = bool
  # default     = false  # Default to false to disable HOMEFOLDER
}

// Scalling Policy
variable "scale_out_metric_interval_upper_bound" {}
variable "scale_out_adjustment" {}
variable "scale_in_metric_interval_upper_bound" {}
variable "scale_in_adjustment" {}
