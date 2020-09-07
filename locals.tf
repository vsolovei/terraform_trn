locals {
  region = "us-east-1"
  vpc_name = "${var.prefix}-vpc"
  eks_name = "${var.prefix}-eks_cluster"
  vpc_cidr = "10.0.0.0/16"

# networks
  public =  var.pub_subnets
  dbs    =  var.dbs_subnets
  eks    =  var.eks_subnets
  vpn    =  var.vpn_subnets
  lb     =  var.lb_subnets
  int    =  var.int_subnets

  subnets = merge(local.eks, local.vpn, local.lb, local.int)

  create_if_public_subnets_exist = length(var.vpn_subnets) > 0 ? 1 : 0
  create_eips                    = length(var.custom_eips_for_nat) == 0 ? var.vpn_subnets : {}

}