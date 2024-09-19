data "aws_availability_zones" "available" {}


locals {
  name   = "doctolib-vpc" #var.name
  region = "eu-east-1" #var.region

  vpc_cidr = "10.0.0.0/16" #var.vpc_cidr
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.name
  cidr = local.vpc_cidr

  azs              = local.azs
  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
  database_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 8)]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
#Database
/*
module "database" {
  source = "./modules/rds"

  project_name       = "doctlibdb"
  security_group_ids = [aws_security_group.compliant.id]

  subnet_ids = module.vpc.database_subnets
  credentials = {
    username = "dbadmin"
    password = "dbadmin123!!"
  }
}
*/