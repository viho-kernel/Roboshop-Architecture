module "sg" {
    count = length(var.sg_names)
    source = "git::https://github.com/viho-kernel/Roboshop-SG.git?ref=main"
    project = var.project
    environment = var.environment
    owner = var.owner
    sg_name = replace(var.sg_names[count.index], "_", "-")
    vpc_id = local.vpc_id
}