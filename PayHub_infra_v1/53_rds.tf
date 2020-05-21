/*
resource "aws_db_subnet_group" "Postgres_DB_Subnet_Group" {
  name       = "${lower(local.name_prefix)}_subnet_group"
  subnet_ids = [aws_subnet.RDSYS_PRIVATE_SUBNET.id, aws_subnet.RDSYS_PUBLIC_SUBNET.id]

  tags = {
      "Name" = "RDSYS-SUBNET-GROUP"
    }
}

#========================================
# App Postgres RDS Server

resource "aws_db_instance" "Postgres_DB_Instance" {
  allocated_storage      = var.allocated_storage
  storage_type           = "gp2"
  engine                 = var.engine_name
  engine_version         = var.engine_version
  instance_class         = var.db_instance_type
  name                   = var.db_name
  username               = var.username
  password               = var.password
  identifier             = "${lower(local.name_prefix)}-rds"
  storage_encrypted      = true
  vpc_security_group_ids = [aws_security_group.RDSYS_SG.id]
  db_subnet_group_name   = aws_db_subnet_group.Postgres_DB_Subnet_Group.id
  multi_az               = true
  skip_final_snapshot    = true

  tags = {
      "Name" = "RDSYS-RDS"
    }
}

*/