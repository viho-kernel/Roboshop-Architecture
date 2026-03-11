resource "aws_lb" "backend_alb" {
  name               = "${var.project}-${var.environment}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend_alb_sg_id]
  subnets            = local.private_subnet

  enable_deletion_protection = false


  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}"
        Environment = var.environment
    }
  )
}