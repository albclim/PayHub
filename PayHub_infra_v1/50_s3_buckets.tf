
resource "aws_s3_bucket" "backups_bucket"{
	bucket = "rdsys-backups007"
  acl    = "private"
}
