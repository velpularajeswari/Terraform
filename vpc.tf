resource "aws_vpc" "demo-vpc" {
    cidr_block = "10.10.0.0/16"

    tags = {
      Name = "Myvpc"
    }
}
resource "aws_subnet" "demo_subnet" {
    vpc_id = aws_vpc.demo-vpc.id
    cidr_block = "10.10.1.0/24"
    tags = {
      Name = "demo-subnet"
    }
}
resource "aws_internet_gateway" "demo-igw" {
    vpc_id = aws_vpc.demo-vpc.id
    tags = {
        Name = "demo-igw"
    }
}
resource "aws_route_table" "demo-rt" {
    vpc_id = aws_vpc.demo-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo-igw.id
    }
    tags = {
      Name = "demo-rt"
    }
}
resource "aws_route_table_association" "demo-rt_association" {
  subnet_id      = aws_subnet.demo_subnet.id
  route_table_id = aws_route_table.demo-rt.id
}
resource "aws_security_group" "demo-vpc-sg" {
  name        = "demo-vpc-sg"
  vpc_id      = aws_vpc.demo-vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}