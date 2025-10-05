variable "region" {
  type        = string
  description = "description"
}

variable "vpc_cidr" {
  type        = string
  description = "description"
}

# variable "ses_email_reciever" {
#   type = string
#   description = "description"
# }

variable "common_resource_name" {
  type        = string
  description = "description"
}




# variable "machine_details" {
#   type        = object({
#     type = string,
#     public_ip = bool
#   })
#   description = "description"
# }


# variable subnets_details {
#   type        = list(object({
#     name = string,
#     cidr = string,
#     type = string,
#     az = string
#   }))
#   description = "description"
# }

variable subnets_details {
  type = map(object({
    name = string,
    cidr = string,
    type = string,
    az = string
  }))
  description = "description"
}

# variable create_key_file {
#   type        = bool
#   description = "description"
# }


variable "cluster_version" {
  description = "Kubernetes version for the cluster"
  type        = string
}

variable "is_eks_role_enabled" {
  type = bool
}
variable "is_eks_node_group_role_enabled" {
  type = bool
}


variable "instance_types" {
  description = "Instance types for worker nodes"
  type        = string
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

variable "desired_capacity" {
  type = number
}
variable "min_capacity" {
  type = number
}
variable "max_capacity" {
  type = number
}

variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))
}