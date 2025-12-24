packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "source_ami" {
  type    = string
  default = "ami-068c0051b15cdb816" # Amazon Linux 2
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

source "amazon-ebs" "web_server" {
  region          = var.aws_region
  source_ami      = var.source_ami
  instance_type   = var.instance_type
  ssh_username    = "ec2-user"
  ami_name        = "web-server-ami-{{timestamp}}"
  ami_description = "NGINX Web Server AMI"

  tags = {
    Name        = "WebServer-AMI"
    Environment = "Production"
    SourceAMI   = var.source_ami
    PackerBuild = "true"
  }
}

build {
  sources = ["source.amazon-ebs.web_server"]

  provisioner "shell" {
    script = "scripts/setup.sh"
  }

  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }
}
