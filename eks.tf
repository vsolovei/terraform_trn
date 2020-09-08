module "ekscluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 12.0"

  cluster_name = local.eks_name
  cluster_version  = "1.17"
  subnets          = values(aws_subnet.eks)[*].id
  vpc_id           = aws_vpc.default.id
  write_kubeconfig = false
  manage_aws_auth  = true

  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  node_groups = {
    default = {
      name             = "${var.prefix}-eks-nodes"
      desired_capacity = 2
      max_capacity     = 6
      min_capacity     = 2
      instance_type    = "t3.large"
    }
  }

}

// needed for datadog DaemonSet
resource "aws_security_group_rule" "cluster-ingress-managed-nodes" {
  description              = "Allow pods to communicate with the cluster API Server"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "all"
  security_group_id        = module.ekscluster.worker_security_group_id
  source_security_group_id = module.ekscluster.cluster_primary_security_group_id
}

resource "aws_iam_policy" "cloudwatch-access" {
  name   = "${var.prefix}-allow-push-to-cloudwatch"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "logs",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:CreateLogGroup"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*"
            ]
        }
    ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "cloudwatch-access" {
  role = module.ekscluster.worker_iam_role_name
  policy_arn = aws_iam_policy.cloudwatch-access.arn
}


provider "kubernetes" {
  version                = "~>  1.11"
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.default.token
  load_config_file       = false
}
