variable "aws_region" {
  type        = string
  description = "AWS region where the AMI will be built"
  default     = "us-east-1"
}

variable "source_ami" {
  type        = string
  description = "Base Amazon Linux 2 AMI"
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type used for AMI build"
  default     = "t2.micro"
}
source "amazon-ebs" "web_server" {
  region        = var.aws_region
  source_ami    = var.source_ami
  instance_type = var.instance_type

  ssh_username = "ec2-user"

  ami_name        = "web-server-ami-{{timestamp}}"
  ami_description = "NGINX Web Server AMI built with Packer"

  tags = {
    Name        = "WebServer-AMI"
    Environment = "Production"
    PackerBuild = "true"
  }
}
build {
  sources = [
    "source.amazon-ebs.web_server"
  ]

  provisioner "shell" {
    script = "scripts/setup.sh"
  }

  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }
}
