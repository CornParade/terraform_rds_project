resource "aws_vpc" "test_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "test_vpc"
  }
}


#resource "aws_subnet" "subnet_a" {
#  vpc_id     = aws_vpc.test_vpc.id
#  cidr_block = "10.0.1.0/24"
#  availability_zone = "eu-west-2a"
#}


#resource "aws_subnet" "subnet_b" {
#  vpc_id     = aws_vpc.test_vpc.id
#  cidr_block = "10.0.2.0/24"
#  availability_zone = "eu-west-2b"
#}


# Security Groups
resource "aws_security_group" "test_web_sg" {
    name = "test_web_sg"
    description = "Security group for web servers"
    vpc_id = aws_vpc.test_vpc.id
    ingress {
        description = "Allow all traffic through HTTP."
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow SSH from specific IP."
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["${var.my_ip}/32"]
    }
    egress {
        description = "Allow all outbound traffic."
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "test_web_sg"
    }
}


resource "aws_security_group" "rds_security_group" {
  name_prefix = "rds-"
  vpc_id = aws_vpc.test_vpc.id

  # Add any additional ingress/egress rules as needed
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.test_web_sg.id]
  }
}