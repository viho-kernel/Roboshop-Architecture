resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project}/${var.environment}/VPC"
  type  = "String"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet" {
  name  = "/${var.project}/${var.environment}/public_subnet"
  type  = "StringList"
  value = local.public_subnet
}

resource "aws_ssm_parameter" "private_subnet" {
  name  = "/${var.project}/${var.environment}/private_subnet"
  type  = "StringList"
  value = local.private_subnet
}

resource "aws_ssm_parameter" "database_subnet" {
  name  = "/${var.project}/${var.environment}/database_subnet"
  type  = "StringList"
  value = local.database_subnet
}