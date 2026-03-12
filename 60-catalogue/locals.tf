locals {
  ami = data.aws_ami.joindevops.id
  private_subnet = split (",", data.aws_ssm_parameter.private_subnet.value)[0]
  catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
        common_tags = {
    project = var.project
    environment = var.environment
    owner = var.owner
  }
}