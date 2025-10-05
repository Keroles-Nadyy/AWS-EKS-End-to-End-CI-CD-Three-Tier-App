# ==================================== EKS Cluster ======================================
resource "aws_eks_cluster" "eks_cluster" {
  # to skip creation in case, with existing IAM roles in enterprise setups.
  count    = var.is_eks_cluster_enabled == true ? 1 : 0
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role[count.index].arn
  version  = var.cluster_version

  vpc_config {
    # subnet_ids              = [aws_subnet.private-subnet[0].id, aws_subnet.private-subnet[1].id, aws_subnet.private-subnet[2].id]
    # subnet_ids = [for subnet in var.subnets_details : subnet.id if subnet.type == "private"]
    subnet_ids = [for subnet in var.subnets_details : subnet.id if subnet.tags["Type"] == "private"]

    # restrict the API access
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access

    security_group_ids = var.cluster_sg_ids
  }


  access_config {
    authentication_mode = "CONFIG_MAP"
    # Grants admin (cluster-admin) permissions to whoever created the cluster
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_AmazonEKSClusterPolicy,
  ]

  tags = {
    Name = var.cluster_name
  }
}

# ==================================== EKS OIDC Provider ======================================
# Get the cluster’s OIDC issuer URL
data "tls_certificate" "eks-certificate" {
  url = aws_eks_cluster.eks_cluster[0].identity[0].oidc[0].issuer
}

# Create an IAM OIDC provider
resource "aws_iam_openid_connect_provider" "eks_OIDC" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks-certificate.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.eks-certificate.url
}

# Retrieve authentication token
# data "aws_eks_cluster_auth" "eks" {
#   name = var.cluster_name
# }

# ==================================== EKS Cluster AddOns ======================================
resource "aws_eks_addon" "eks_addons" {
  for_each      = { for idx, addon in var.addons : idx => addon }
  cluster_name  = aws_eks_cluster.eks_cluster[0].name
  addon_name    = each.value.name
  addon_version = each.value.version

  depends_on = [
    aws_eks_node_group.eks_node_group
  ]
}

# ==================================== EKS Cluster Node Group ======================================
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster[0].name
  node_group_name = "${var.cluster_name}-nodes"

  node_role_arn = aws_iam_role.eks_node_group_role[0].arn
  # subnet_ids    = [aws_subnet.private-subnet[0].id, aws_subnet.private-subnet[1].id, aws_subnet.private-subnet[2].id]
  subnet_ids = [for subnet in var.subnets_details : subnet.id if subnet.tags["Type"] == "private"]

  instance_types = [ var.instance_types ]

  scaling_config {
    desired_size = var.desired_capacity
    min_size     = var.min_capacity
    max_size     = var.max_capacity
  }

  update_config {
    max_unavailable = 1
  }
  tags = {
    "Name" = "${var.cluster_name}-nodes"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_AmazonWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_AmazonEC2ContainerRegistryReadOnly,
    aws_eks_cluster.eks_cluster
  ]
}
