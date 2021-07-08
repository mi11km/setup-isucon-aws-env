resource "aws_vpc" "defalut_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "default_public_subnet" {
  vpc_id                  = aws_vpc.defalut_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "default_internet_gateway" {
  vpc_id = aws_vpc.defalut_vpc.id
}

resource "aws_route_table" "default_rtb" {
  vpc_id = aws_vpc.defalut_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default_internet_gateway.id
  }
}

# サブネットにルートテーブルを紐付け
resource "aws_route_table_association" "default_rtb_subnet_association" {
  subnet_id      = aws_subnet.default_public_subnet.id
  route_table_id = aws_route_table.default_rtb.id
}

resource "aws_security_group" "defalut_security_group" {
  name        = "allow-ssh"
  vpc_id      = aws_vpc.defalut_vpc.id
  description = "Allow SSH port"

  ingress {
    from_port   = 22
    to_port     = 22
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