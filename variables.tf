variable "instance_name" {
  description = "Value of the EC2 instance's Name tag."
  type        = string
  default     = "Tank_Terraform_Deploy"
}

variable "instance_type" {
  description = "The EC2 instance's type."
  type        = string
  default     = "t3.large"
}

variable "instance_id" {
  description = "ID of the existing EC2 instance to reference (e.g. i-0abcd1234efgh5678)."
  type        = string
  default     = "i-0f5c47136adc0901d"
}

variable "security_group_name"{
    description = "ID of the existing security group to reference"
    type        = string
    default     = "launch-wizard-3"
}