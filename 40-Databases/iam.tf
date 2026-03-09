resource "aws_iam_role" "mysql" {
  name = local.mysql_role_name #Roboshop-Dev-Mysql

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    {
        Name = local.mysql_role_name
    },
    local.common_tags
  )
}

resource "aws_iam_policy" "mysql" {
  name        = local.mysql_policy_name
  description = "A policy for MySQL Ec2 instance"
  policy      = templatefile("mysql-iam-policy.json",  {
                env = var.environment
  })
}


resource "aws_iam_role_policy_attachment" "mysql" {
  role       = aws_iam_role.mysql.name
  policy_arn = aws_iam_policy.mysql.arn
}

resource "aws_iam_instance_profile" "mysql" {
  name = "${var.project}-${var.environment}-mysql"
  role = aws_iam_role.mysql.name
}



resource "aws_iam_role" "rabbitmq"{
  name = local.rabbitmq_role_name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    {
        Name = local.rabbitmq_role_name
    },
    local.common_tags
  )
}

resource "aws_iam_policy" "rabbitmq_user" {
  name        = local.rabbitmq_policy_name
  description = "A policy for RabbitMQ Ec2 instance"
  policy      = templatefile("rabbitmq-iam-user-policy.json",
  {
                env = var.environment
  })
}

resource "aws_iam_policy" "rabbitmq_password"{
  name        = local.rabbitmq_policy_password_name
  description = "A policy for RabbitMQ Ec2 instance"
  policy      = templatefile("rabbitmq-iam-user-password.json",
  {
                env = var.environment
  })
}
resource "aws_iam_role_policy_attachment" "rabbitmq_user"{
  role       = aws_iam_role.rabbitmq.name
  policy_arn = aws_iam_policy.rabbitmq_user.arn
}

resource "aws_iam_role_policy_attachment" "rabbitmq_password" {
  role       = aws_iam_role.rabbitmq.name
  policy_arn = aws_iam_policy.rabbitmq_password.arn
}

resource "aws_iam_instance_profile" "rabbitmq" {
  name = "${var.project}-${var.environment}-rabbitmq"
  role = aws_iam_role.rabbitmq.name
}