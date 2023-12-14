# RDS
# UN (username) and PW (password) set as ENV variables
resource "aws_db_instance" "default" {
	allocated_storage = 10   # GiB
	storage_type = "gp2"
	engine = "mysql"
	instance_class = "db.t3.micro"
	identifier = "testdb"
	db_name = "testdb"
	username = var.UN
	password = var.PW
	vpc_security_group_ids = [aws_security_group.rds_security_group.id]
	db_subnet_group_name = aws_db_subnet_group.test_subnet_group.id
	backup_retention_period = 7
	backup_window = "00:00-01:00"
	maintenance_window = "mon:01:00-mon:01:30"
	skip_final_snapshot = true
	final_snapshot_identifier = "db-snap-${formatdate("YYYYMMDDhhmmss", timestamp())}"
}

# Subnets and Internet Gateway
resource "aws_db_subnet_group" "test_subnet_group" {
	name = "test_subnet_group"
	subnet_ids = [for subnet in aws_subnet.test_private_subnet : subnet.id]
}


# Public Subnet
resource "aws_subnet" "test_public_subnet" {
	count = var.subnet_count.public
	vpc_id = aws_vpc.test_vpc.id
	cidr_block = var.public_subnet_cidr_blocks[count.index]
	availability_zone = data.aws_availability_zones.available.names[count.index]
	map_public_ip_on_launch = true
	tags = {
		Name = "test_public_subnet_${count.index}"
	}
}


# Private Subnet
resource "aws_subnet" "test_private_subnet" {
	count = var.subnet_count.private
	vpc_id = aws_vpc.test_vpc.id
	cidr_block = var.private_subnet_cidr_blocks[count.index]
	availability_zone = data.aws_availability_zones.available.names[count.index]
	tags = {
		Name = "test_private_subnet_${count.index}"
	}
}


resource "aws_internet_gateway" "test_igw" {
	vpc_id = aws_vpc.test_vpc.id
	tags = {
		Name = "test_igw"
	}
}


# Route Tables
resource "aws_route_table" "test_public_rt"{
	vpc_id = aws_vpc.test_vpc.id
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.test_igw.id
	}
}


resource "aws_route_table_association" "public" {
	count = var.subnet_count.public
	route_table_id = aws_route_table.test_public_rt.id
	subnet_id = aws_subnet.test_public_subnet[count.index].id
}


resource "aws_route_table" "test_private_rt" {
	vpc_id = aws_vpc.test_vpc.id
}


resource "aws_route_table_association" "private" {
	count = var.subnet_count.private
	route_table_id = aws_route_table.test_private_rt.id
	subnet_id = aws_subnet.test_private_subnet[count.index].id
}


# Key Pair
resource "aws_key_pair" "test_kp" {
	key_name = "test_kp"
	public_key = file("test_kp.pub")
}


# Instances
resource "aws_instance" "test_ec2_1" {
  count = 1
  ami           = "ami-0ff1c68c6e837b183"  # Publically available EC2 AMI for example purposes
  instance_type = "t2.micro"
  subnet_id = aws_subnet.test_public_subnet[count.index].id
  key_name = aws_key_pair.test_kp.key_name
  vpc_security_group_ids = [aws_security_group.test_web_sg.id]
  tags = {
    Name = "TestExample1"
  }
}

resource "aws_instance" "test_ec2_2" {
  count = 1
  ami           = "ami-0ff1c68c6e837b183"  # Publically available EC2 AMI for example purposes
  instance_type = "t2.micro"
  subnet_id = aws_subnet.test_public_subnet[count.index].id
  key_name = aws_key_pair.test_kp.key_name
  vpc_security_group_ids = [aws_security_group.test_web_sg.id]
  tags = {
    Name = "TestExample2"
  }
}

resource "aws_instance" "test_ec2_3" {
  count = 1
  ami           = "ami-0ff1c68c6e837b183"  # Publically available EC2 AMI for example purposes
  instance_type = "t2.micro"
  subnet_id = aws_subnet.test_public_subnet[count.index].id
  key_name = aws_key_pair.test_kp.key_name
  vpc_security_group_ids = [aws_security_group.test_web_sg.id]
  tags = {
    Name = "TestExample3"
  }
}

