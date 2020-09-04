output "this_vpc_id" {
  value = aws_vpc.default.id
}

output "subnets_public" {
  value = {
    ids = values(aws_subnet.public)[*].id
    arn = values(aws_subnet.public)[*].arn
  }
}

output "subnets_int" {
  value = {
    ids = values(aws_subnet.internal)[*].id
 arn = values(aws_subnet.internal)[*].arn
  }
}

output "subnets_dbs" {
  value = {
    ids = values(aws_subnet.db)[*].id
    arn = values(aws_subnet.db)[*].arn
  }
}

output "subnets_eks" {
  value = {
    ids = values(aws_subnet.eks)[*].id
    arn = values(aws_subnet.eks)[*].arn
  }
}

output "subnets_vpn" {
  value = {
    ids = values(aws_subnet.vpn)[*].id
    arn = values(aws_subnet.vpn)[*].arn
  }
}
