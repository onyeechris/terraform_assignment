# Windows PowerShell - Set AWS Credentials
# Usage: .\set-aws-creds.ps1

# Standard AWS environment variables (for S3 backend)
$env:AWS_ACCESS_KEY_ID = "<AWS_ACCESS_KEY_ID>"
$env:AWS_SECRET_ACCESS_KEY = "<AWS_SECRET_ACCESS_KEY>"
$env:AWS_DEFAULT_REGION = "us-east-1"

# Terraform environment variables (for provider)
$env:TF_VAR_aws_access_key_id = "<AWS_ACCESS_KEY_ID>"
$env:TF_VAR_aws_secret_access_key = "<AWS_SECRET_ACCESS_KEY>"

Write-Host "✅ AWS credentials set for current session" -ForegroundColor Green
terraform init
terraform validate
terraform plan