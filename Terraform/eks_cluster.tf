module "eks" {
  source                         = "./modules/eks"
  cluster_name                   = "${var.common_resource_name}-Cluster"
  is_eks_cluster_enabled         = var.is_eks_cluster_enabled
  is_eks_role_enabled            = var.is_eks_role_enabled
  is_eks_node_group_role_enabled = var.is_eks_node_group_role_enabled
  cluster_version                = var.cluster_version
  endpoint_private_access        = var.endpoint_private_access
  endpoint_public_access         = var.endpoint_public_access
  subnets_details                = module.network_module.subnets
  common_resource_name           = var.common_resource_name
  instance_types                 = var.instance_types
  min_capacity                   = var.min_capacity
  max_capacity                   = var.max_capacity
  desired_capacity               = var.desired_capacity
  addons                         = var.addons
  cluster_sg_ids                  = [module.network_module.eks_cluster_sg_id]
}
# module.iam.eks_cluster_role_arn
