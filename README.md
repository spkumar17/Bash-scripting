#                                                                                  Terraform

## What is Terraform?

Terraform is a HashiCorp tool that is cloud-agnostic, which means you can use the same logic to deploy resources across multiple clouds, including AWS, Azure, and GCP.

## Why Terraform?

Terraform offers greater flexibility and multi-cloud support compared to cloud-native tools like CloudFormation (CFT) and Azure Resource Manager (ARM). It simplifies resource management through modules, reusable code, and a powerful state management system.

### Key Differences between CNT (CFT, ARM) & Terraform:

| Feature                          | CFT & ARM                           | Terraform                      |
|-----------------------------------|--------------------------------------|---------------------------------|
| Language                          | JSON or YAML (All configs in one file) | HashiCorp Configuration Language (HCL) |
| Complexity                        | Learning JSON/YAML is difficult       | HCL is simpler and modular     |
| Cloud Compatibility               | AWS (CFT), Azure (ARM) only          | Multi-cloud (AWS, Azure, GCP)  |
| Module Support                    | No                                  | Yes, with reusable modules     |
| Workspace Support                 | No                                  | Yes, supports multiple workspaces |
| Dry-Run Capability                | Limited                             | `terraform plan` for effective dry-run |
| Importing Resources               | Complex in AWS, not available in ARM | Simple with `terraform import` |

## Data sources:

Data sources in Terraform is used to fetch information about existing resources, such as VPC IDs, subnet IDs, security group IDs, etc. Once you retrieve this information, you can use it in your Terraform configurations to create or manage other resources.

### Example:
Fetching AZ'S using data source and creating subnets in that AZ
``` 
data "aws_availability_zones" "available_zones" {
  state = "available"
}

#public subnets 
resource "aws_subnet" "pubsubnet1a" {
    vpc_id     = aws_vpc.myvpc.id
    availability_zone = data.aws_availability_zones.available_zones.names[0]
    cidr_block = var.pubsub1a_cidr_block
    map_public_ip_on_launch = true



  tags = {
    Name = "pubsubnet_us_east_1a"
  }
}
```
## What is Terraform import:

The terraform import command in Terraform is used to bring existing infrastructure under Terraform's management. It allows you to take resources that were created manually (or by another tool) and incorporate them into your Terraform state, without the need to recreate them.

## Why  terraform import?

#### Manage existing resources: 
If you have infrastructure that wasn’t created with Terraform, you can start managing it using Terraform by importing the resources.
#### Avoid downtime:
It helps you bring existing resources into Terraform without destroying or re-creating them, so there’s no downtime for critical services.
#### Infrastructure consolidation:
When migrating from manual cloud setups to Infrastructure as Code (IaC), terraform import allows for a smooth transition.

 ### Work-flow:

#### Step1:   Import the existing infrastructure:

You run the terraform import command to import the manually created infrastructure into Terraform's state file. This step only updates the state file but does not update or create any configuration in your .tf files.

```
terraform import aws_instance.my_instance i-1234567890abcdef
```
After running this command, Terraform will know about this resource (aws_instance.my_instance) and track its state.

#### Step 2:  Write the corresponding Terraform configuration

You need to manually write the Terraform configuration for the imported resource in your .tf files. The configuration must match the existing resource exactly

```
resource "aws_instance" "my_instance" {
  instance_type = "t2.micro"
  ami           = "ami-0abcdef1234567890"
  # Other attributes that reflect the current state
}
```
After writing the configuration, Terraform will manage this resource as part of its lifecycle.

Then run ``` terraform plan```  to verify.

## Difference between Data Source and Terraform import:

| Feature               | Terraform Import                          | Data Source                             |
|-----------------------|------------------------------------------|-----------------------------------------|
| **Use case**          | Manage an existing resource with Terraform | Fetch information from an existing resource |
| **Modifies state?**   | Yes, adds the resource to Terraform's state | No, only fetches data                   |
| **Manages lifecycle?**| Yes, Terraform manages the resource's lifecycle | No, Terraform doesn't control the resource |
| **Typical usage**     | Transitioning existing infra to Terraform | Referencing attributes like ID, region, status, etc. |



