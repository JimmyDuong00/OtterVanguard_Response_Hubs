terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  # Configuration options
}

# Create VPC
resource "aws_vpc" "vanguard_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create Subnet 1
resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.vanguard_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-1b"

  tags = {
    Name = "subnet_1"
  }
}

# Create Subnet 2
resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.vanguard_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-1c"

  tags = {
    Name = "subnet_2"
  }
}

# Create Security Group to allow SSH
resource "aws_security_group" "ssh_sg" {
  vpc_id = aws_vpc.vanguard_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow all IPs for SSH access (use more restrictive CIDR in production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

# Deploy 3 EC2 instances in Subnet 1
resource "aws_instance" "instances_in_subnet_1" {
  count           = 2
  ami             = "ami-025258b26b492aec6" # Specify your desired AMI (Amazon Linux 2 for example)
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.subnet_1.id
  vpc_security_group_ids = [aws_security_group.ssh_sg.id]

  tags = {
    Name = "instance_in_subnet_1_${count.index + 1}"
  }
}

# Deploy 3 EC2 instances in Subnet 2
resource "aws_instance" "instances_in_subnet_2" {
  count           = 2
  ami             = "ami-025258b26b492aec6" # Specify your desired AMI
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.subnet_2.id
  vpc_security_group_ids = [aws_security_group.ssh_sg.id]

  tags = {
    Name = "instance_in_subnet_2_${count.index + 1}"
  }
}
