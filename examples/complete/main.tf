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
  # source          = "git::ssh://git@github.com/inflearn/terraform-aws-vpc.git?ref=v3.14.0"\
  source          = "../../../terraform-aws-vpc"
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
  source  = "../../"
  name    = "example-inflab-efs-"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets

  access_points = [
    {
      root_directory = "/"
      posix_user = {
        gid = "0"
        uid = "0"
      }
      creation_info = {
        owner_gid   = "0"
        owner_uid   = "0"
        permissions = "0755"
      }
    }
  ]

  tags = {
    iac  = "terraform"
    temp = "true"
  }
}
