output "mysql" {
  value = aws_instance.mysql.private_ip
}

output "rabbitmq" {
  value = aws_instance.rabbitmq.private_ip
}

output "redis"{
  value = aws_instance.redis.private_ip
}

output "mongodb"{
  value = aws_instance.mongodb.private_ip
}