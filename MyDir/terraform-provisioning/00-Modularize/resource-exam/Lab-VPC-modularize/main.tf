terraform {
  required_providers {
    aws = { source = "hashicorp/aws"
      version = "~> 5.46"
    }
  }

  backend "s3" {
    bucket = "2411-rednine-tf-backend-bucket"
    key    = "terraform.tfstate"
    region = "ap-northeast-2"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "hong-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-northeast-2a", "ap-northeast-2c"]
  private_subnets = ["10.0.0.0/24", "10.0.1.0/24"]
  public_subnets  = ["10.0.100.0/24", "10.0.101.0/24"]

  // 모듈을 이용하면 igw 는 자동 생성됨. 123

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  tags = {
    Terraform   = "true"
    Environment = terraform.workspace
  }
}


