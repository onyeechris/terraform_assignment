#!/bin/bash

# DevOps Portfolio Web Server Setup Script
# This script installs and configures nginx with a custom portfolio page

# Enable logging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "Starting user data script execution at $(date)"

# Update system packages
echo "Updating system packages..."
yum update -y

# Install nginx
echo "Installing nginx..."
sudo yum install -y nginx

# Start and enable nginx service
echo "Starting nginx service..."
sudo systemctl start nginx
sudo systemctl enable nginx

# Create custom welcome page
echo "Creating custom portfolio page..."
cat > /usr/share/nginx/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to AKA Christian Onyekachukwu's Portfolio</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            max-width: 600px;
            text-align: center;
            animation: fadeIn 1s ease-in;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }
        .intro {
            color: #666;
            font-size: 1.2em;
            line-height: 1.6;
            margin: 20px 0;
        }
        .highlight {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .skills {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin: 20px 0;
        }
        .skill-card {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid #667eea;
        }
        .footer {
            margin-top: 30px;
            color: #888;
            font-size: 0.9em;
            border-top: 1px solid #eee;
            padding-top: 20px;
        }
        .tech-stack {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 10px;
            margin: 20px 0;
        }
        .tech-badge {
            background: #e9ecef;
            color: #495057;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 500;
        }
        .status-indicator {
            display: inline-block;
            width: 10px;
            height: 10px;
            background: #28a745;
            border-radius: 50%;
            margin-right: 8px;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }
        @media (max-width: 768px) {
            .container {
                margin: 20px;
                padding: 30px 20px;
            }
            h1 {
                font-size: 2em;
            }
            .intro {
                font-size: 1.1em;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to my SITE</h1>
        <div class="intro">
            <p><strong>My name is AKA CHRISTIAN ONYEKACHUKWU.</strong></p>
            <div class="highlight">
                <p><strong>I am a seasoned DevOps engineer, with AI knowledge. It is also right to assert that I have more than four years of professional experience in this role.</strong></p>
            </div>
            
            <div class="skills">
                <div class="skill-card">
                    <h3>🚀 DevOps Expertise</h3>
                    <p>Infrastructure as Code, CI/CD, Cloud Architecture</p>
                </div>
                <div class="skill-card">
                    <h3>🤖 AI Knowledge</h3>
                    <p>Machine Learning Operations, AI/ML Pipelines</p>
                </div>
                <div class="skill-card">
                    <h3>☁️ Cloud Platforms</h3>
                    <p>AWS, Azure, Google Cloud Platform</p>
                </div>
                <div class="skill-card">
                    <h3>🔧 Automation</h3>
                    <p>Terraform, Ansible, Kubernetes, Docker</p>
                </div>
            </div>

            <div class="tech-stack">
                <span class="tech-badge">AWS</span>
                <span class="tech-badge">Terraform</span>
                <span class="tech-badge">Docker</span>
                <span class="tech-badge">Kubernetes</span>
                <span class="tech-badge">Jenkins</span>
                <span class="tech-badge">Python</span>
                <span class="tech-badge">Linux</span>
                <span class="tech-badge">Git</span>
            </div>
            
            <p>This infrastructure was provisioned using <strong>Terraform</strong> and showcases modern DevOps practices including Infrastructure as Code, automated deployment, and cloud-native architecture.</p>
        </div>
        <div class="footer">
            <p><span class="status-indicator"></span><strong>System Status:</strong> Online and Operational</p>
            <p><strong>Powered by:</strong> AWS EC2 | Deployed with Terraform | Managed by nginx</p>
            <p><strong>Last Updated:</strong> <span id="timestamp"></span></p>
        </div>
    </div>

    <script>
        // Display current timestamp
        document.getElementById('timestamp').textContent = new Date().toLocaleString();
        
        // Add some interactivity
        document.querySelectorAll('.skill-card').forEach(card => {
            card.addEventListener('mouseenter', () => {
                card.style.transform = 'translateY(-5px)';
                card.style.transition = 'transform 0.3s ease';
            });
            card.addEventListener('mouseleave', () => {
                card.style.transform = 'translateY(0)';
            });
        });
    </script>
</body>
</html>
EOF

# Set proper permissions
sudo chmod 644 /usr/share/nginx/html/index.html

# Configure nginx (optional: create custom nginx config)
echo "Configuring nginx..."

# Test nginx configuration
nginx -t

# Restart nginx to apply changes
echo "Restarting nginx service..."
sudo systemctl restart nginx

# Verify nginx is running
sudo systemctl status nginx

# Check if nginx is listening on port 80
netstat -tulnp | grep :80 || ss -tulnp | grep :80

# # Create a simple health check endpoint
# cat > /usr/share/nginx/html/health << 'EOF'
# {
#   "status": "healthy",
#   "service": "nginx",
#   "timestamp": "$(date -Iseconds)",
#   "uptime": "$(uptime -p)"
# }
# EOF

# # Log completion
# echo "Web server setup completed successfully at $(date)"
# echo "Nginx status:"
# systemctl is-active nginx
# echo "Portfolio website is now available!"

# # Optional: Install additional monitoring tools
# echo "Installing additional tools..."
# yum install -y htop curl wget

# # Set up log rotation for custom logs
# cat > /etc/logrotate.d/user-data << 'EOF'
# /var/log/user-data.log {
#     daily
#     missingok
#     rotate 7
#     compress
#     delaycompress
#     notifempty
#     copytruncate
# }
# EOF

echo "Setup script execution completed at $(date)"