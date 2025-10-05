output "cluster_id" {
  description = "EKS cluster ID"
  value = var.is_eks_cluster_enabled ? aws_eks_cluster.eks_cluster[0].id : null
}

output "cluster_name" {
  description = "EKS cluster name"
  value = var.is_eks_cluster_enabled ? aws_eks_cluster.eks_cluster[0].name : null
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value = var.is_eks_cluster_enabled ? aws_eks_cluster.eks_cluster[0].endpoint : null
}

output "cluster_certificate_authority" {
  description = "Base64 encoded certificate data"
  value = var.is_eks_cluster_enabled ? aws_eks_cluster.eks_cluster[0].certificate_authority[0].data : null
}

output "node_group_arn" {
  description = "Node group ARN"
  value       = aws_eks_node_group.eks_node_group.arn
}

output "cluster_security_group_id" {
  description = "Security group ID attached to cluster"
  value       = var.is_eks_cluster_enabled ? aws_eks_cluster.eks_cluster[0].vpc_config[0].cluster_security_group_id : null
  
}

output "oidc_provider_arn" {
  description = "ARN of the OIDC provider"
  value       = aws_iam_openid_connect_provider.eks_OIDC.arn
}