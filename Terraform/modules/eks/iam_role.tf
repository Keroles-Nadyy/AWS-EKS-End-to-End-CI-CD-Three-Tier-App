# ==================================== EKS Cluster Role ======================================
resource "aws_iam_role" "eks_cluster_role" {
  # to skip role creation in case, with existing IAM roles in enterprise setups.
  count = var.is_eks_role_enabled == true ? 1 : 0
  name = "${var.common_resource_name}_eks_cluster_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSClusterPolicy" {
  count      = var.is_eks_role_enabled ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role[count.index].name
}

# ==================================== EKS NodeGroup Role ======================================
resource "aws_iam_role" "eks_node_group_role" {
  #
  count = var.is_eks_node_group_role_enabled ? 1 : 0
  name = "${var.common_resource_name}eks-node-group-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# gives permissions to EKS worker nodes to Join cluster, Communicate with API, etc..
resource "aws_iam_role_policy_attachment" "eks_AmazonWorkerNodePolicy" {
  count      = var.is_eks_node_group_role_enabled ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group_role[count.index].name
}

# gives permissions to the Amazon VPC CNI plugin used by EKS worker nodes.
resource "aws_iam_role_policy_attachment" "eks_AmazonEKS_CNI_Policy" {
  count      = var.is_eks_node_group_role_enabled ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group_role[count.index].name
}

# allows read-only access to ECR to Authenticate to ECR, and Pull images
resource "aws_iam_role_policy_attachment" "eks_AmazonEC2ContainerRegistryReadOnly" {
  count      = var.is_eks_node_group_role_enabled ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group_role[count.index].name
}

# allows to provision, attach, and manage Amazon EBS volumes used as persistent storage for your pods.
resource "aws_iam_role_policy_attachment" "eks_AmazonEBSCSIDriverPolicy" {
  count      = var.is_eks_node_group_role_enabled ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.eks_node_group_role[count.index].name
}

# ==================================== EKS OIDC (OpenID Connect) Role ======================================
# data "aws_iam_policy_document" "eks_assume_role" {
#   statement {
#     effect  = "Allow"
#     actions = ["sts:AssumeRole"]
#     principals {
#       type        = "Service"
#       identifiers = ["eks.amazonaws.com"]
#     }
#   }
# }

# Define an IAM Role for a specific service account
data "aws_iam_policy_document" "eks_oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks_OIDC.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:default:aws-test"]
    }

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.eks_OIDC.arn]
    }
  }
}

resource "aws_iam_role" "eks_oidc" {
  assume_role_policy = data.aws_iam_policy_document.eks_oidc_assume_role_policy.json
  name               = "eks_oidc"
}

resource "aws_iam_policy" "eks_OIDC_policy" {
  name = "test-policy"

  policy = jsonencode({
    Statement = [{
      Action = [
        "s3:ListAllMyBuckets",
        "s3:GetBucketLocation",
        "*"
      ]
      Effect   = "Allow"
      Resource = "*"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks_OIDC_policy_attachment" {
  role       = aws_iam_role.eks_oidc.name
  policy_arn = aws_iam_policy.eks_OIDC_policy.arn
}