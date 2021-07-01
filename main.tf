terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}

# variables
variable "ami_id" {
  type    = string
  default = "ami-03bbe60df80bdccc0" # デフォルトは第１０回予選のやつ
}

variable "key_name" {
  type    = string
  default = "id_rsa_ec2"
}

variable "public_key" {
  type    = string
  default = "id_rsa_ec2.pub"
}

# key pair
resource "aws_key_pair" "ssh-key-pair" {
  key_name   = var.key_name
  public_key = file(var.public_key)
}

# ec2 instance
resource "aws_instance" "test_server" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  tags = {
    Name = "ISUCONTestServer"
  }
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.defalut_security_group.id]
  subnet_id              = aws_subnet.default_public_subnet.id
}

output "ip_address" {
  value = aws_instance.test_server.public_ip
}

