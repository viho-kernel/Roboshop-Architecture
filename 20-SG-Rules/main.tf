resource "aws_security_group_rule" "local_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [local.cidr_block]
  security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
  description       = "Allow ssh access to bastion host"
}

resource "aws_security_group_rule" "bastion_mongodb" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = local.bastion
  security_group_id        = local.mongodb
  description              = "Allow ssh access from bastion to mongodb host"
}

resource "aws_security_group_rule" "bastion_redis" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = local.bastion
  security_group_id        = local.redis
  description              = "Allow ssh access from bastion to redis host"
}

resource "aws_security_group_rule" "bastion_mysql" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = local.bastion
  security_group_id        = local.mysql
  description              = "Allow ssh access from bastion to mysql host"
}

resource "aws_security_group_rule" "bastion_rabbitmq" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = local.bastion
  security_group_id        = local.rabbitmq
  description              = "Allow ssh access from bastion to rabbitmq host"
}

resource "aws_security_group_rule" "catalogue_mongodb" {
    type = "ingress"
    from_port = 27017
    to_port = 27017
    protocol = "tcp"
    source_security_group_id =  local.catalogue
    security_group_id = local.mongodb
    description = "Allow port access from catalogue to mongodb"
  
}

resource "aws_security_group_rule" "user_mongodb" {
    type = "ingress"
    from_port = 27017
    to_port = 27017
    protocol = "tcp"
    source_security_group_id =  local.user
    security_group_id = local.mongodb
    description = "Allow port access from user  to mongodb" 
}

resource "aws_security_group_rule" "user_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = local.user
  security_group_id        = local.redis
  description              = "Allow User access in Redis"
}

resource "aws_security_group_rule" "cart_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = local.cart
  security_group_id        = local.redis
  description              = "Allow Cart access in  Redis"
}

resource "aws_security_group_rule" "shipping_mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = local.shipping
  security_group_id        = local.mysql
  description              = "Allow Shipping access in MySQL"
}

resource "aws_security_group_rule" "payment_rabbitmq" {
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  source_security_group_id = local.payment
  security_group_id        = local.rabbitmq
  description              = "Allow Payment access in RabbitMQ"
}