#!/bin/bash
# Linux/Mac - Set AWS Credentials
# Usage: source set-aws-creds.sh

# Standard AWS environment variables (for S3 backend)
export AWS_ACCESS_KEY_ID="AKIAS252WKUKOWFKJPUN"
export AWS_SECRET_ACCESS_KEY="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"
export AWS_DEFAULT_REGION="us-east-1"

# Terraform environment variables (for provider)
export TF_VAR_aws_access_key_id="AKIAS252WKUKOWFKJPUN"
export TF_VAR_aws_secret_access_key="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"

echo "✅ AWS credentials set for current session"