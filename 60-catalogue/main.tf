resource "aws_instance" "catalogue" {
    ami = local.ami
    instance_type = "t3.micro"
    subnet_id = local.private_subnet
    vpc_security_group_ids = [local.catalogue_sg_id]

    tags = merge(
        local.common_tags,
        {
Name = "${var.project}-${var.environment}-catalogue"
        }
    )

  
}

resource "terraform_data" "catalogue" {
    triggers_replace = [
        aws_instance.catalogue.id
    ]  

    connection {
      type = "ssh"
      user = "ec2-user"
      password = "DevOps321"
      host = aws_instance.catalogue.private_ip
    }

    provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
    }

    provisioner "remote-exec" {

        inline = [ 
            "chmod +x bootstrap.sh",
            "sudo sh bootstrap.sh catalogue dev"

         ]
      
    }

}

resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id 
  state       = "stopped"
  depends_on = [ terraform_data.catalogue ]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "${var.project}-${var.environment}-catalogue"
  source_instance_id = aws_ec2_instance_state.catalogue.id
  tags = merge(
        local.common_tags,
        {
             Name = "${var.project}-${var.environment}-catalogue"
        }
    )

    depends_on = [ aws_ec2_instance_state.catalogue ]
}

resource "aws_lb_target_group" "catalogue" {
  name     = "${var.project}-${var.environment}-catalogue"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_ssm_parameter.vpc_id.value
}