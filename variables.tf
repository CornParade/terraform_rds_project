variable "UN" {
	type = string
	sensitive = true
}


variable "PW" {
	type = string
	sensitive = true
}


variable "my_ip" {
	type = string
	sensitive = true
}


variable "aws_region" {
	default = "eu-west-2"
}

variable "subnet_count" {
	description = "Number of subnets used"
	type = map(number)
	default = {
		public = 1,
		private = 2
	}
}


variable "public_subnet_cidr_blocks" {
	description = "Available CIDR blocks for public subnets"
	type = list(string)
	default = [
		"10.0.10.0/24",
		"10.0.20.0/24",
		"10.0.30.0/24",
		"10.0.40.0/24",
	]
}


variable "private_subnet_cidr_blocks" {
	description = "Available CIDR blocks for private subnets"
	type = list(string)
	default = [
		"10.0.101.0/24",
		"10.0.102.0/24",
		"10.0.103.0/24",
		"10.0.104.0/24",
	]
}


variable "vpc_cidr_block" {
	description = "CIDR block for VPC"
	type = string
	default = "10.0.0.0/16"
}