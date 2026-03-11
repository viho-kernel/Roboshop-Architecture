locals {
  private_subnet = split ( "," , data.aws_ssm_parameter.private_subnet.value)
        common_tags = {
    project = var.project
    environment = var.environment
    owner = var.owner
  }

  backend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg_id.value
}