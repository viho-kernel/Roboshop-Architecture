terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = " ~> 6.3.0 "
    }
  }
  backend "s3" {

    bucket  = "roboshop-infra-dev-bucket"
    key     = "Dev::roboshop-sg-rules"
    region  = "us-east-1"
    encrypt = true

  }
}

provider "aws" {
  region = "us-east-1"
}