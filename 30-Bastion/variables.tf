variable "project" {
    type = string
    default = "Roboshop"
}

variable "environment" {
    type = string
    default = "Dev"
}

variable "owner" {
    type = string
    default = "Vihari"
}

variable "bastion_tags" {
    type = map(string)
    default = {}
  
}