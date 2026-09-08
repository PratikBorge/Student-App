resource "aws_db_subnet_group" "db_subnet_group" {
    name = "db_subnet_group"
    subnet_ids = var.subnet_ids
    tags = {
        Name = "db_subnet_group"
    }
}
resource "aws_db_instance" "db_instance" {
    allocated_storage = 10
    engine = var.aws_db_engine
    engine_version = var.aws_db_engine_version
    instance_class = var.aws_db_instance_class
    port = var.aws_db_port
    storage_encrypted = true
    kms_key_id = "arn:aws:kms:ap-southeast-1:267307198563:key/52566c30-bcc7-4219-9f8b-59b371fd9241"
    storage_type = var.aws_db_storage_type
    identifier = "studentapp"
    db_name = "studentapp"
    username = var.aws_db_master_username
    password = var.aws_db_master_user_password
    skip_final_snapshot = true
    vpc_security_group_ids =  var.vpc_security_group_ids
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
}
