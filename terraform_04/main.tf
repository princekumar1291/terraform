# Key Pair
resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file("my_key.pub")
}

# Default VPC
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# Default Subnet in ap-south-1a
resource "aws_default_subnet" "default_a" {
  availability_zone = "ap-south-1a"
}

# Security Group
resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP (8080)"
    from_port   = 8080
    to_port     = 8080
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

# EC2 Instance
resource "aws_instance" "my_instance" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_instance_type
  key_name               = aws_key_pair.my_key.key_name
  subnet_id              = aws_default_subnet.default_a.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  user_data = file("install_nginx.sh")

  root_block_device {
    volume_size = var.ec2_root_storage_size
  }

  tags = {
    Name = "MyInstance"
  }
}
