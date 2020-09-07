data "aws_region" "current" {}
resource "aws_subnet" "public" {
  for_each = var.pub_subnets

  vpc_id                  = aws_vpc.default.id
  cidr_block              = each.value
  availability_zone       = "${data.aws_region.current.name}${each.key}"

  tags = merge(var.tags, var.public_subnet_tags, {
    Name = "${var.prefix}-public-${each.key}"
  })
}

resource "aws_subnet" "eks" {
  for_each = var.eks_subnets

  vpc_id                  = aws_vpc.default.id
  cidr_block              = each.value
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_region.current.name}${each.key}"

  tags = merge(var.tags, var.eks_subnet_tags, {
    Name = "${var.prefix}-eks-${each.key}"
  })
}

resource "aws_subnet" "internal" {
  for_each = var.int_subnets

  vpc_id                  = aws_vpc.default.id
  cidr_block              = each.value
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_region.current.name}${each.key}"

  tags = merge(var.tags, var.internal_subnet_tags, {
    Name = "${var.prefix}-internal-${each.key}"
  })
}

resource "aws_subnet" "lb" {
  for_each = var.lb_subnets

  vpc_id                  = aws_vpc.default.id
  cidr_block              = each.value
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_region.current.name}${each.key}"

  tags = merge(var.tags, var.lb_subnet_tags, {
    Name = "${var.prefix}-lb-${each.key}"
  })
}

resource "aws_subnet" "db" {
  for_each = var.dbs_subnets

  vpc_id = aws_vpc.default.id
  cidr_block = each.value
  map_public_ip_on_launch = false
  availability_zone = "${data.aws_region.current.name}${each.key}"

  tags = merge(var.tags, var.db_subnet_tags, {
    Name = "${var.prefix}-db-${each.key}"
  })
}

resource "aws_subnet" "vpn" {
  for_each = var.vpn_subnets

  vpc_id = aws_vpc.default.id
  cidr_block = each.value
  map_public_ip_on_launch = false
  availability_zone = "${data.aws_region.current.name}${each.key}"

  tags = merge(var.tags, var.vpn_subnet_tags, {
    Name = "${var.prefix}-vpn-${each.key}"
  })
}
