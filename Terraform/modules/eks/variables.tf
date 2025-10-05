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

# variable "private_subnet_ids" {
#   description = "List of private subnet IDs for EKS"
#   type        = list(string)
# }

# variable "desired_size" {
#   description = "Desired number of worker nodes"
#   type        = number
# }

# variable "max_size" {
#   description = "Maximum number of worker nodes"
#   type        = number
# }

# variable "min_size" {
#   description = "Minimum number of worker nodes"
#   type        = number
# }

variable "instance_types" {
  description = "Instance types for worker nodes"
  type        = string
}

# variable "enable_public_endpoint" {
#   description = "Enable public access to Kubernetes API"
#   type        = bool
#   default     = false
# }

# variable "key_pair_name" {
#   description = "SSH key pair name for worker nodes"
#   type        = string
#   default     = ""
# }

# variable "cluster_role_arn" {
#   description = "IAM role ARN for the EKS cluster"
#   type        = string
# }

# variable "node_role_arn" {
#   description = "IAM role ARN for the EKS worker nodes"
#   type        = string
# }

# variable "security_group_ids" {
#   description = "List of security group IDs to attach to the EKS nodes"
#   type        = list(string)
# }

# variable "eks_worker_sg_id" {
#   description = "Security group ID to attach to worker nodes"
#   type        = string
# }

#IAM
variable "is_eks_role_enabled" {
  type = bool
}
variable "is_eks_node_group_role_enabled" {
  type = bool
}

# EKS
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
