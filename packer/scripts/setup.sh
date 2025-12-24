#!/bin/bash

# Update system packages
sudo yum update -y

# Install NGINX
sudo yum install -y nginx

# Enable and start NGINX
sudo systemctl enable nginx
sudo systemctl start nginx

# Create a custom index page
echo "<html>
  <head><title>Automated AMI</title></head>
  <body>
    <h1>Success! Built with Packer and GitHub Actions</h1>
    <p>This AMI was baked automatically.</p>
  </body>
</html>" | sudo tee /usr/share/nginx/html/index.html
