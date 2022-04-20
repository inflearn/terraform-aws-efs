terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.75.1"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "vpc" {
  source          = "git::ssh://git@github.com/inflearn/terraform-aws-vpc.git?ref=v3.14.0"
  name            = "example-inflab-efs"
  cidr            = "10.0.0.0/16"
  azs             = ["ap-northeast-2a"]
  private_subnets = ["10.0.0.0/24"]

  tags = {
    iac  = "terraform"
    temp = "true"
  }
}

module "efs" {
  source     = "../../"
  prefix     = "example-inflab-efs-"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  tags = {
    iac  = "terraform"
    temp = "true"
  }
}
