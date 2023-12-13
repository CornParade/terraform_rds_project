# UN (username) and PW (password) set as ENV variables
resource "aws_db_instance" "default" {
	allocated_storage = 100   # GiB
	storage_type = "gp2"
	engine = "mysql"
	instance_class = "db.t3.micro"
	identifier = "testdb"
	username = var.UN
	password = var.PW
	vpc_security_group_ids = [aws_security_group.rds_security_group.id]
	db_subnet_group_name = aws_db_subnet_group.test_subnet_group.name
	backup_retention_period = 7
	backup_window = "00:00-01:00"
	maintenance_window = "mon:01:00-mon:01:30"
	skip_final_snapshot = false
	final_snapshot_identifier = "db-snap"
}

resource "aws_db_subnet_group" "test_subnet_group" {
	name = "test_subnet_group"
	subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
	tags = {
		Name = "Subnet Group"
	}
}