locals {
  region = "us-east-1"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "${var.prefix}-vpc"
  eks_name = "${var.prefix}-eks_cluster"
  prefix = var.prefix

# networks
  public =  var.pub_subnets
  dbs    =  var.dbs_subnets
  eks    =  var.eks_subnets
  vpn    =  var.vpn_subnets
  lb     =  var.lb_subnets
  int    =  var.int_subnets

  subnets = merge(local.eks, local.vpn, local.lb, local.int)

}