locals {
      common_tags = {
    project = var.project
    environment = var.environment
    owner = var.owner
  }
  ami_id = data.aws_ami.joindevops.id
  public_subnet = split(",", data.aws_ssm_parameter.public_subnet.value)[0]
}