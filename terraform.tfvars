# AWS Configuration
region            = "us-east-1"
availability_zone = "us-east-1a"

# Network Configuration
vpc_cidr_block = "10.0.0.0/16"

# EC2 Configuration
instance_type = "t2.micro"
ami_id        = "ami-05ffe3c48a9991133"

# AWS Credentials (Set these values securely)
aws_access_key_id     = "YOUR_ACCESS_KEY_ID"
aws_secret_access_key = "YOUR_SECRET_ACCESS_KEY"

# Note: For security, consider using environment variables instead:
# export TF_VAR_aws_access_key_id="your_access_key"
# export TF_VAR_aws_secret_access_key="your_secret_key"
