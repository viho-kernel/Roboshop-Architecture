locals {
      common_tags = {
    project = var.project
    environment = var.environment
    owner = var.owner
  }
  ami_id = data.aws_ami.joindevops.id
  database_subnet_id = split(",", data.aws_ssm_parameter.database_subnet_id.value)[0]
  mongodb = data.aws_ssm_parameter.mongodb_sg_id.value
  redis = data.aws_ssm_parameter.redis_sg_id.value
  mysql = data.aws_ssm_parameter.mysql_sg_id.value
  rabbitmq = data.aws_ssm_parameter.rabbitmq_sg_id.value
}