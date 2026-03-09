variable "project" {
    type = string
    default = "roboshop"
}

variable "environment" {
    type = string
    default = "dev"
}

variable "owner" {
    type = string
    default = "Vihari"
}

variable "bastion_tags" {
    type = map(string)
    default = {}
  
}