output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "website_url" {
  description = "URL to access the website"
  value       = "http://${aws_instance.web.public_ip}"
}

output "access_instructions" {
  description = "Instructions on how to access the website"
  value       = <<-EOT
    🌐 Website Access Instructions:
    
    1. Open your web browser
    2. Navigate to: http://${aws_instance.web.public_ip}
    3. You should see AKA Christian Onyekachukwu's professional portfolio page
    
    📊 Infrastructure Details:
    - Instance ID: ${aws_instance.web.id}
    - Instance Type: ${aws_instance.web.instance_type}
    - Availability Zone: ${aws_instance.web.availability_zone}
    - VPC ID: ${aws_vpc.main.id}
    
    🔒 SSH Access (if needed):
    ssh -i your-key.pem ec2-user@${aws_instance.web.public_ip}
  EOT
}

output "infrastructure_status" {
  description = "Current status of the infrastructure deployment"
  value = {
    vpc_id            = aws_vpc.main.id
    subnet_id         = aws_subnet.public.id
    security_group_id = aws_security_group.web.id
    instance_id       = aws_instance.web.id
    public_ip         = aws_instance.web.public_ip
    deployment_status = "Successfully Deployed"
    architecture      = "Single-tier Web Application"
    cloud_provider    = "AWS"
    region            = var.region
  }
}
