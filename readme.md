## Note: get the deployment steps at the end of this documentation
Module/Architecture Documentation
Module Overview

This Terraform module implements a comprehensive Infrastructure-as-Code solution for deploying a professional DevOps portfolio website on AWS. The module demonstrates modern cloud architecture patterns, automated deployment strategies, and DevOps best practices through a scalable, secure, and cost-effective infrastructure design.

Module Purpose: Deploy a production-ready web application infrastructure that showcases DevOps expertise while maintaining simplicity, security, and operational excellence.

Architecture Overview

This infrastructure implements a simple, scalable web application architecture on AWS using Infrastructure as Code (Terraform). The system showcases a professional DevOps portfolio site with automated deployment, proper networking, and security best practices. The architecture follows a single-tier web application pattern optimized for demonstration and cost-effectiveness while maintaining production-ready principles.

```
┌─────────────────────────────────────┐
│        Internet (0.0.0.0/0)        │
└─────────────────┬───────────────────┘
                  │
┌─────────────────▼───────────────────┐
│         Internet Gateway            │
│         (IGW)                       │
└─────────────────┬───────────────────┘
                  │
┌─────────────────▼───────────────────┐
│              VPC                    │
│         (10.0.0.0/16)              │
│  ┌─────────────────────────────────┐│
│  │      Route Table                ││
│  │   (Public Routes)               ││
│  └─────────────┬───────────────────┘│
│                │                    │
│  ┌─────────────▼───────────────────┐│
│  │        Public Subnet            ││
│  │       (10.0.1.0/24)            ││
│  │  ┌─────────────────────────────┐││
│  │  │    Security Group           │││
│  │  │   (HTTP/HTTPS/SSH)          │││
│  │  │  ┌─────────────────────────┐│││
│  │  │  │     EC2 Instance        ││││
│  │  │  │   (t2.micro + nginx)    ││││
│  │  │  │   Portfolio Website     ││││
│  │  │  └─────────────────────────┘│││
│  │  └─────────────────────────────┘││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

## Terraform Module Structure

Module Inputs (Variables)

| Variable | Type | Default | Description | Required |
|----------|------|---------|-------------|----------|
| `region` | string | `"us-east-1"` | AWS region for resource deployment | No |
| `vpc_cidr_block` | string | `"10.0.0.0/16"` | CIDR block for VPC network | No |
| `aws_access_key_id` | string | - | AWS Access Key ID for authentication | Yes |
| `aws_secret_access_key` | string | - | AWS Secret Access Key for authentication | Yes |
| `availability_zone` | string | `"us-east-1a"` | Availability zone for subnet placement | No |
| `instance_type` | string | `"t2.micro"` | EC2 instance type for web server | No |
| `ami_id` | string | `"ami-05ffe3c48a9991133"` | Amazon Machine Image ID | No |

Module Outputs

| Output | Type | Description |
|--------|------|-------------|
| `ec2_public_ip` | string | Public IP address of the EC2 instance |
| `website_url` | string | Complete URL to access the portfolio website |
| `access_instructions` | string | Detailed instructions for accessing and managing the infrastructure |
| `infrastructure_status` | object | Comprehensive status object with all resource IDs and deployment information |

Module Resources


Compute Resources

# EC2 Instance - Web server hosting portfolio
resource "aws_instance" "web" {
  ami                    = "ami-05ffe3c48a9991133"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]
  
  # User data script for automated setup
  user_data = file("${path.module}/scripts/setup-webserver.sh")
  user_data_replace_on_change = true
}

Core Layers

Infrastructure Layer
VPC (Virtual Private Cloud)
- Provides isolated network environment with full control over IP addressing
- CIDR: 10.0.0.0/16 (65,536 IP addresses available)
- DNS resolution and hostnames enabled for proper service discovery
- Foundation for all networking components with security boundaries

Public Subnet
- CIDR: 10.0.1.0/24 (256 IP addresses available)
- Auto-assigns public IPs to instances for direct internet access
- Direct internet connectivity via Internet Gateway
- Located in us-east-1a availability zone for consistent deployment
- Supports high availability and future multi-AZ expansion

Internet Gateway
- Bidirectional internet access for VPC resources
- Enables public IP connectivity for web services
- Route target for all internet-bound traffic from public subnet
- Managed AWS service with built-in redundancy

Route Table
- Directs traffic from public subnet (10.0.1.0/24) to Internet Gateway
- Default route (0.0.0.0/0) for internet access
- Associated with public subnet for proper traffic flow
- Supports custom routing for future network expansion

Compute Layer
EC2 Instance (t2.micro)
- Cost-effective compute instance (AWS Free Tier eligible)
- AMI: ami-05ffe3c48a9991133 (Amazon Linux 2 - optimized for AWS)
- 1 vCPU, 1 GB RAM - sufficient for demonstration and light production workloads
- nginx web server with custom configuration and professional portfolio
- Automated setup via user data script with comprehensive error handling
- Professional portfolio webpage deployment with modern design

Security Layer
Security Group (Web Server)
- Inbound Rules:
  - HTTP (port 80): Open to internet (0.0.0.0/0) for web traffic
  - HTTPS (port 443): Open to internet (0.0.0.0/0) for secure web traffic  
  - SSH (port 22): Open to internet (0.0.0.0/0) for administrative access
- Outbound Rules: All traffic allowed for system updates and external dependencies
- Acts as virtual firewall at instance level with stateful connection tracking
- Follows principle of least privilege with explicit rule definitions

Module Configuration

Provider Configuration

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

### Backend Configuration

terraform {
  backend "s3" {
    bucket = "akachristianonyekachukwudevops"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
```

Cross-cutting Concerns

Security
Network Security:
- VPC isolation provides network-level security boundaries
- Security groups act as instance-level firewalls with explicit rules
- Public subnet design with controlled access points
- No direct internet access to private resources

Access Control:
- SSH access available for administrative tasks and troubleshooting
- HTTP/HTTPS ports open for web traffic with proper security group rules
- All security rules explicitly defined with principle of least privilege
- IAM roles and policies for secure AWS service interactions

State Security:
- Terraform state stored remotely in S3 with encryption at rest
- Sensitive variables marked as such to prevent exposure in logs
- Credentials managed through variables with environment variable support
- State locking and versioning for team collaboration

Data Security:
- All data transmission over HTTPS when SSL certificates are configured
- Instance-level security with regular security updates via user data
- Network ACLs and security groups providing defense in depth

Configuration Management
Infrastructure as Code:
- All infrastructure defined in Terraform HCL with version control
- Declarative configuration ensuring consistent deployments
- Repeatable and consistent deployments across environments
- Complete infrastructure reproducibility

Environment Configuration:
- Variables for environment-specific values (dev, staging, prod)
- Default values for common configurations to reduce complexity
- tfvars files for easy customization and environment separation
- Support for multiple deployment environments

State Management:
- Remote backend using S3 bucket for centralized state storage
- State locking and consistency to prevent concurrent modifications
- Team collaboration support with shared state management
- State backup and recovery procedures

Modular Design:
- Clean separation of concerns with logical resource grouping
- Reusable components for different environments
- Standard module structure following Terraform best practices
- Easy to extend and modify for additional requirements

Integration Patterns

## State Management
Remote Backend Pattern:
- S3 bucket: `akachristianonyekachukwudevops`
- State file: `terraform.tfstate`
- Region: `us-east-1`
- Enables team collaboration and state consistency
- Provides backup and versioning capabilities

Variable Management:
- Sensitive credentials through environment variables for security
- Configuration values through tfvars files for flexibility
- Default values for common settings to reduce configuration overhead
- Support for multiple environments with variable overrides

Deployment Pattern
User Data Bootstrap:
- Automated nginx installation and configuration
- Custom HTML content deployment with professional design
- Service configuration and startup with health checks
- Zero-touch deployment process with comprehensive logging
- Error handling and service verification

Resource Dependencies:
- Implicit dependencies through Terraform references ensuring proper order
- Proper creation order (VPC → Subnet → Instance) managed automatically
- Dependency graph optimization for efficient deployments
- Automatic cleanup in reverse dependency order

Monitoring and Observability
Logging Strategy:
- User data script execution logged to `/var/log/user-data.log`
- System logs available through CloudWatch (when configured)
- nginx access and error logs for web traffic analysis
- Centralized logging for troubleshooting and monitoring

## Component Interactions

Core Data Flows

1. Internet Traffic Flow:
  
   Internet → Internet Gateway → Route Table → Public Subnet → Security Group → EC2 Instance → nginx → Response
   

2. Security Flow:
   
   Incoming Request → Security Group Rules → EC2 Instance → nginx → Portfolio Website → Response
   

3. Deployment Flow:
 
   Terraform Apply → AWS API → Resource Creation → User Data Execution → Service Configuration → Website Ready
  

4. State Management Flow:
   
   Terraform Command → Remote Backend (S3) → State Locking → Resource Modification → State Update
  

Dependencies

Network Dependencies:
- VPC must exist before any subnets can be created
- Internet Gateway must be attached to VPC before routing
- Route table must reference Internet Gateway for internet access
- Subnet must be associated with route table for proper routing
- Security group requires VPC for network boundary definition

Compute Dependencies:
- EC2 instance requires subnet for network placement
- EC2 instance requires security group for access control
- Security group requires VPC for network context
- User data script executes after instance creation and network setup

State Dependencies:
- Backend configuration must be valid before any operations
- Provider authentication must succeed before resource creation
- Variable values must be available before resource planning
- Dependencies resolved automatically by Terraform dependency graph


Resource Interface Contracts:
- VPC provides isolated network environment with DNS support
- Subnet provides IP address range with public IP assignment
- Security Group provides controlled access with explicit rules
- EC2 provides compute capacity with automated configuration
- Internet Gateway provides internet connectivity for public resources

Output Interface:

output "website_url" {
  description = "URL to access the website"
  value       = "http://${aws_instance.web.public_ip}"
}

output "infrastructure_status" {
  description = "Current status of the infrastructure deployment"
  value = {
    vpc_id           = aws_vpc.main.id
    instance_id      = aws_instance.web.id
    public_ip        = aws_instance.web.public_ip
    deployment_status = "Successfully Deployed"
  }
}


Web Service Interface
HTTP Endpoint:
- Protocol: HTTP (port 80) with HTTPS (port 443) support
- Content-Type: text/html with responsive design
- Response: Custom professional portfolio webpage
- Availability: Public internet accessible with global reach


Infrastructure Management Interface:
- Terraform outputs provide all necessary access information
- Complete access instructions with URLs and connection details
- Infrastructure status with resource identifiers
- Administrative access via SSH with proper key management

## Module Usage

Basic Usage

module "devops_portfolio" {
  source = "./devops-portfolio-infrastructure"
  
  # Required variables
  aws_access_key_id     = var.aws_access_key_id
  aws_secret_access_key = var.aws_secret_access_key
  
  # Optional customization
  region                = "us-west-2"
  vpc_cidr_block       = "10.1.0.0/16"
  instance_type        = "t3.micro"
}

## Deployment Instructions

Prerequisites
1. AWS Account with programmatic access and appropriate permissions
2. Terraform installed (>= 1.0) with proper PATH configuration
3. S3 bucket `akachristianonyekachukwudevops` (with `Block all public access` not enabled) exists for state storage
4. Proper IAM permissions for EC2, VPC, and related services

## Module Deployment Steps

1. `FOR WINDOWS`
    Open the `set-aws-creds.ps1` file and set `<AWS_ACCESS_KEY_ID>` and `<AWS_SECRET_ACCESS_KEY>` to your `<AWS_ACCESS_KEY_ID>` and `<AWS_SECRET_ACCESS_KEY>` respectively.

   cd to the project directory with your terminal and run the command:
   `.\set-aws-creds.ps1`

2.   `FOR Linux/Mac`
    Open the `set-aws-creds.sh` file and set `<AWS_ACCESS_KEY_ID>` and `<AWS_SECRET_ACCESS_KEY>` to your `<AWS_ACCESS_KEY_ID>` and `<AWS_SECRET_ACCESS_KEY>` respectively.

   cd to the project directory with your terminal and run the command:
   `.\set-aws-creds.sh`

3. Initialize the module

`terraform init`

4. Validate configuration

`terraform validate`

5. Plan deployment

`terraform plan` 

6. Apply configuration

`terraform apply --auto-approve`

7. To take down the environment simply run

`terraform destroy --auto-approve`


## Post-Deployment Verification

Check website accessibility
Copy thye URL displayed in the terminal, after deployment, and paste on the browser the check the website

Verify infrastructure status
terraform output infrastructure_status
