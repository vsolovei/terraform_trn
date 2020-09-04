provider "aws" {
  region = local.region
}

locals {
  tags = {
    Environment = "dev"
  }

  vpc_tags = {
    VPCTag = "true"
  }


  int_subnets = {
    "a" = "10.0.20.0/24"
    "b" = "10.0.21.0/24"
  }

  lb_subnets = {
    "a" = "10.0.20.0/24"
    "b" = "10.0.21.0/24"
  }

  vpn_subnets = {
    "a" = "10.0.50.0/24"
    "b" = "10.0.51.0/24"
  }

  eks_subnets = {
    "a" = "10.0.30.0/24"
    "b" = "10.0.31.0/24"
  }

  dbs_subnets = {
    "a" = "10.0.10.0/24"
    "b" = "10.0.11.0/24"

  }
  pub_subnets = {
    "a" = "10.0.101.0/24"
    "b" = "10.0.102.0/24"
  }

  internal_subnet_tags = "int"
  db_subnet_tags = "db"
  vpn_subnet_tags = "vpn"
  public_subnet_tags = "pub"
  lb_subnet_tags = "lb"
  eks_subnet_tags = "eks"
}
