# Windows PowerShell - Set AWS Credentials
# Usage: .\set-aws-creds.ps1

# Standard AWS environment variables (for S3 backend)
$env:AWS_ACCESS_KEY_ID = "AKIAS252WKUKOWFKJPUN"
$env:AWS_SECRET_ACCESS_KEY = "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"
$env:AWS_DEFAULT_REGION = "us-east-1"

# Terraform environment variables (for provider)
$env:TF_VAR_aws_access_key_id = "AKIAS252WKUKOWFKJPUN"
$env:TF_VAR_aws_secret_access_key = "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"

Write-Host "✅ AWS credentials set for current session" -ForegroundColor Green