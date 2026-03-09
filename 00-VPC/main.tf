module "vpc" {
  source      = "git::https://github.com/viho-kernel/Roboshop-VPC.git?ref=main"
  project     = "Roboshop"
  environment = "Dev"
  owner       = "Vihari"
  is_peering_required = true

}