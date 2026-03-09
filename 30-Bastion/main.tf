resource "aws_instance" "bastion" {
    ami = local.ami_id
    vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
    subnet_id = local.public_subnet
    iam_instance_profile = aws_iam_instance_profile.test_profile.name
    user_data = file("bastion.sh")
    instance_type = "t3.micro"
    root_block_device {
       volume_size = 50
    volume_type = "gp3"
    # EBS volume tags
    tags = merge(
      {
          Name = "${var.project}-${var.environment}-bastion"
      },
    local.common_tags
    )
}

    tags = merge(
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}-Bastion-EC2"
        },
        var.bastion_tags
    )


}

resource "aws_iam_role" "bastion" {
  name = "RoboshopDevBastion"
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
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-iam"
    }
  )
}

resource "aws_iam_role_policy_attachment" "example" {
  role       = aws_iam_role.bastion.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "test_profile" {
  name = "${var.project}-${var.environment}-bastion"
  role = aws_iam_role.bastion.name
}