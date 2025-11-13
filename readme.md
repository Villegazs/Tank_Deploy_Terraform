# Tank Deploy Terraform - AWS EC2 Instance

This Terraform configuration provisions an EC2 instance in AWS for deploying the Tank application using Docker.

## Project Structure

```
├── main.tf                    # Main infrastructure configuration
├── variables.tf               # Variable definitions
├── outputs.tf                 # Output definitions
├── versions.tf                # Terraform and provider version constraints
├── user_data.sh              # Instance initialization script
├── terraform.tfvars.example  # Example configuration file
├── app.py                    # Python application
├── requirements.txt          # Python dependencies
└── deploy.yml               # Deployment configuration
```

## Prerequisites

1. **Terraform**: Install Terraform (>= 1.0)
2. **AWS Account**: Active AWS account with appropriate permissions
3. **AWS CLI**: Configured AWS CLI (optional, for easier credential management)
4. **Key Pair**: AWS key pair created in your target region

## Setup Instructions

### 1. Configure Credentials

#### Option A: Using terraform.tfvars (Recommended)
```bash
# Copy the example file
cp terraform.tfvars.example terraform.tfvars

# Edit terraform.tfvars with your values
```

#### Option B: Using Environment Variables
```bash
export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
export AWS_DEFAULT_REGION="us-east-1"
```

#### Option C: Using AWS CLI Profile
```bash
aws configure --profile terraform
export AWS_PROFILE=terraform
```

### 2. Customize Configuration

Edit the variables in `terraform.tfvars`:

```hcl
aws_region           = "us-east-1"
instance_name        = "Tank_Terraform_Deploy"
instance_type        = "t3.large"
key_name            = "your-key-pair-name"
security_group_name = "your-security-group-name"
```

### 3. Deploy Infrastructure

```bash
# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply the configuration
terraform apply
```

### 4. Access Your Instance

After deployment, use the outputs to connect:

```bash
# Get the public IP
terraform output public_ip

# SSH to the instance
ssh -i /path/to/your-key.pem ubuntu@$(terraform output -raw public_ip)
```

## What Gets Deployed

- **EC2 Instance**: Ubuntu 22.04 LTS instance
- **Security Group**: Uses existing security group (configure ports as needed)
- **Docker Setup**: Automatically installs Docker and Docker Compose
- **Application**: Clones and runs the Tank application

## Important Notes

1. **Security**: Never commit `terraform.tfvars` to version control
2. **Costs**: Remember to destroy resources when not needed: `terraform destroy`
3. **Monitoring**: Instance has detailed monitoring enabled
4. **AMI**: Uses the latest Ubuntu 22.04 LTS AMI automatically

## Troubleshooting

### Common Issues

1. **Authentication Error**: Verify AWS credentials
2. **Key Pair Not Found**: Ensure the key pair exists in your AWS region
3. **Security Group Not Found**: Verify the security group name/ID
4. **Insufficient Permissions**: Ensure your AWS user has EC2 permissions

### Useful Commands

```bash
# Check current state
terraform show

# List all resources
terraform state list

# Get specific output
terraform output instance_id

# Force refresh state
terraform refresh

# Clean up everything
terraform destroy
```

## Security Considerations

- Instance uses IMDSv2 for enhanced security
- Ensure your security group has appropriate rules
- Use strong key pairs and rotate regularly
- Monitor instance access logs

## Contributing

When making changes:
1. Test locally with `terraform plan`
2. Update documentation if needed
3. Follow Terraform best practices
