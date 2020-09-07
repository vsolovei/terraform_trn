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

  internal_subnet_tags = "int"
  db_subnet_tags = "db"
  vpn_subnet_tags = "vpn"
  public_subnet_tags = "pub"
  lb_subnet_tags = "lb"
  eks_subnet_tags = "eks"
}
