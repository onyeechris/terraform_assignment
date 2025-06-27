terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key

  default_tags {
    tags = {
      Project     = "DevOps-Portfolio"
      Owner       = "AKA-CHRISTIAN-ONYEKACHUKWU"
      Environment = "demo"
      ManagedBy   = "Terraform"
    }
  }
}
