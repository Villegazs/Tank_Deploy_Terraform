variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

# Instance Configuration
variable "instance_name" {
  description = "Value of the EC2 instance's Name tag"
  type        = string
  default     = "Tank_Terraform_Deploy"
}

variable "instance_type" {
  description = "The EC2 instance's type"
  type        = string
  default     = "t3.large"
}

variable "key_name" {
  description = "Name of the AWS key pair to use for the instance"
  type        = string
  default     = "llaveIoTpracticas"
}

variable "security_group_name" {
  description = "Name of the existing security group to reference"
  type        = string
  default     = "launch-wizard-3"
}

# Optional: for referencing existing instances
variable "instance_id" {
  description = "ID of the existing EC2 instance to reference (optional)"
  type        = string
  default     = ""
}