# Core Cloud Terraform AWS AppStream2 Module

A Terraform module to provision AWS AppStream 2.0 fleets and associated stacks, including autoscaling policies, CloudWatch alarms, and optional HOMEFOLDER storage connectors.

# Features

* Create one or more AppStream fleets with custom compute capacity and network settings

* Create an AppStream stack and associate it with one fleet

* Configure dynamic user settings and disable application settings

* Optional HOMEFOLDER storage connector via a null_resource provisioner

* Wait-for-fleet script hook to ensure the fleet is running before stack association

* Auto Scaling target, scheduled actions, and step-scaling policies

* CloudWatch alarms for insufficient capacity and low utilization

* Usage report subscription

# Example Usage
Example usage can be found in the README in the modules folder. 
