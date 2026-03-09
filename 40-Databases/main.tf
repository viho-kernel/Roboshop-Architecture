resource "aws_instance" "mongodb" {
    ami = local.ami_id
    subnet_id = local.database_subnet_id
    vpc_security_group_ids = [local.mongodb]
    instance_type = "t3.micro"

    tags = merge(
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}-MongoDB"
        }
    )
}

resource "terraform_data" "mongodb" {

    triggers_replace = [
        aws_instance.mongodb.id
    ]

    connection  {
      type = "ssh"
      user = "ec2-user"
      password = "DevOps321"
      host = aws_instance.mongodb.private_ip
    }
provisioner "file" {
    source      = "bootstrap.sh" # Local file path
    destination = "/tmp/bootstrap.sh"    # Destination path on the remote machine
  }

  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh mongodb"
    ]
  }
}