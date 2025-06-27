# AWS Configuration
region            = "us-east-1"
availability_zone = "us-east-1a"

# Network Configuration
vpc_cidr_block = "10.0.0.0/16"

# EC2 Configuration
instance_type = "t2.micro"
ami_id        = "ami-05ffe3c48a9991133"

# AWS Credentials - Using Environment Variables
# No credentials specified here - will use TF_VAR_aws_access_key_id and TF_VAR_aws_secret_access_key
