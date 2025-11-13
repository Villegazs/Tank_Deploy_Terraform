output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.terraform.id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.terraform.public_ip
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.terraform.private_ip
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.terraform.public_dns
}

output "instance_state" {
  description = "State of the EC2 instance"
  value       = aws_instance.terraform.instance_state
}

output "availability_zone" {
  description = "Availability zone of the EC2 instance"
  value       = aws_instance.terraform.availability_zone
}

output "security_groups" {
  description = "Security groups associated with the instance"
  value       = aws_instance.terraform.vpc_security_group_ids
}