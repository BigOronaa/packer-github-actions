provider "aws" {
  region = "us-east-1"  # Your AWS region
}

# Reference the latest Packer AMI
data "aws_ami" "packer_ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "tag:PackerBuild"
    values = ["true"]
  }
}

# Launch an EC2 instance using the latest Packer AMI
resource "aws_instance" "web" {
  ami           = data.aws_ami.packer_ami.id
  instance_type = "t3.small"  # Matches the instance type used in Packer
  tags = {
    Name        = "WebServer"        # Consistent with Packer tag
    Environment = "Production"       # Optional: match your AMI tag
    SourceAMI   = data.aws_ami.packer_ami.id
  }

  # Optional: Allow SSH and HTTP access (for testing)
  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

# Security group for the instance
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH and HTTP access"
  vpc_id      = aws_vpc.default.id  # Replace with your VPC ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Optional: Output public IP for testing
output "web_instance_public_ip" {
  value = aws_instance.web.public_ip
}
