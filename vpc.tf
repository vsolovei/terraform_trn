module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"
  name = local.vpc_name
  cidr = local.vpc_cidr

  azs = [
    "${local.region}a",
    "${local.region}b"]

  enable_nat_gateway = true

  vpc_tags = {
    "kubernetes.io/cluster/${local.eks_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/role/alb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.eks_name}" = "shared"
  }
}

resource "aws_vpc" "default" {

  cidr_block = local.vpc_cidr

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(var.tags, var.vpc_tags, {
    Name = "${var.prefix}-vpc"
  })
}

  resource "aws_subnet" "public" {
  for_each = var.pub_subnets

  vpc_id                  = aws_vpc.default.id
  cidr_block              = each.value
  availability_zone       = "azs${each.key}"

  tags = merge(var.tags, var.public_subnet_tags, {
    Name = "${var.prefix}-public-${each.key}"
  })
}

resource "aws_subnet" "eks" {
  for_each = var.eks_subnets

  vpc_id                  = aws_vpc.default.id
  cidr_block              = each.value
  map_public_ip_on_launch = false
  availability_zone       = "azs{each.key}"

  tags = merge(var.tags, var.eks_subnet_tags, {
    Name = "${var.prefix}-private-${each.key}"
  })
}

resource "aws_subnet" "internal" {
  for_each = var.int_subnets

  vpc_id                  = aws_vpc.default.id
  cidr_block              = each.value
  map_public_ip_on_launch = false
  availability_zone       = "azs{each.key}"

  tags = merge(var.tags, var.int_subnets, {
    Name = "${var.prefix}-private-${each.key}"
  })
}

resource "aws_subnet" "lb" {
  for_each = var.lb_subnets

  vpc_id                  = aws_vpc.default.id
  cidr_block              = each.value
  map_public_ip_on_launch = false
  availability_zone       = "azs{each.key}"

  tags = merge(var.tags, var.lb_subnets, {
    Name = "${var.prefix}-private-${each.key}"
  })
}

resource "aws_subnet" "db" {
  for_each = var.dbs_subnets

  vpc_id                  = aws_vpc.default.id
  cidr_block              = each.value
  map_public_ip_on_launch = false
  availability_zone       = "azs{each.key}"

  tags = merge(var.tags, var.db_subnet_tags, {
    Name = "${var.prefix}-private-${each.key}"
  })
}


resource "aws_subnet" "vpn" {
  for_each = var.vpn_subnets

  vpc_id                  = aws_vpc.default.id
  cidr_block              = each.value
  map_public_ip_on_launch = false
  availability_zone       = "azs{each.key}"

  tags = merge(var.tags, var.vpn_subnet_tags, {
    Name = "${var.prefix}-private-${each.key}"
  })
}
