resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true


  tags = {
    Name : "dev"
  }

}

resource "aws_subnet" "my_public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "dev_public_subnet"
  }
}

resource "aws_internet_gateway" "my_IGW" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "dev_IGW"
  }

}


resource "aws_route_table" "my_public_route_TB" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "dev_public_route_table"
  }

}


resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.my_public_route_TB.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_IGW.id

}

resource "aws_route_table_association" "public_subnet_association" {
  route_table_id = aws_route_table.my_public_route_TB.id
  subnet_id      = aws_subnet.my_public_subnet.id

}

resource "aws_security_group" "my_sg" {
  name        = "dev_sg"
  description = "dev security group"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}