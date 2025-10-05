variable "common_resource_name" {
  type = string
}

variable "subnets_details" {
  type = any
  description = "description"
}

variable "cluster_sg_ids" {
  description = "Security group ID for the EKS control plane"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the cluster"
  type        = string
}

variable "instance_types" {
  description = "Instance types for worker nodes"
  type        = string
}

variable "is_eks_role_enabled" {
  type = bool
}
variable "is_eks_node_group_role_enabled" {
  type = bool
}

variable "is_eks_cluster_enabled" {
  type = bool
}

variable "endpoint_private_access" {
  type = bool
}
variable "endpoint_public_access" {
  type = bool
}

variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))
}
variable "desired_capacity" {
  type = number
}
variable "min_capacity" {
  type = number
}
variable "max_capacity" {
  type = number
}
