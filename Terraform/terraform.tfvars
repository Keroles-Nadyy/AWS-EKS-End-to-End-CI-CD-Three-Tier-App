vpc_cidr = "10.0.0.0/16"
# region            = "eu-central-1"
region               = "us-east-1"
common_resource_name = "ToDo_NodeJs_App"

# ses_email_reciever = "Keroles_N@outlook.com"

# machine_details={
#     type="t2.micro",
#     public_ip=true
# }

# subnets_details=[
#     {
#         name="public_subnet_I",
#         cidr="10.0.1.0/24",
#         type="public",
#         az = "eu-central-1a"
#     },

#     {
#         name="public_subnet_II",
#         cidr="10.0.2.0/24",
#         type="public",
#         az = "eu-central-1b"
#     },

#     {
#         name="private_subnet_I",
#         cidr="10.0.3.0/24",
#         type="private",
#         az = "eu-central-1a"
#     },
#     {
#         name="private_subnet_II",
#         cidr="10.0.4.0/24",
#         type="private",
#         az = "eu-central-1b"
#     }
# ]

subnets_details = {
  "public_subnet_I" : { name = "public_subnet_I", cidr = "10.0.1.0/24", type = "public", az = "us-east-1a" },
  "public_subnet_II" : { name = "public_subnet_II", cidr = "10.0.2.0/24", type = "public", az = "us-east-1b" },
  "private_subnet_I" : { name = "private_subnet_I", cidr = "10.0.4.0/24", type = "private", az = "us-east-1a" },
  "private_subnet_II" : { name = "private_subnet_II", cidr = "10.0.5.0/24", type = "private", az = "us-east-1b" }
}



# EKS
is_eks_cluster_enabled         = true
is_eks_role_enabled            = true
is_eks_node_group_role_enabled = true
cluster_version                = "1.31"
endpoint_private_access        = true
endpoint_public_access         = false
instance_types                 = "t2.micro"
desired_capacity               = 1
min_capacity                   = 1
max_capacity                   = 3

addons = [
  {
    name    = "vpc-cni",
    version = "v1.19.2-eksbuild.1"
  },
  {
    name    = "coredns"
    version = "v1.11.4-eksbuild.1"
  },
  {
    name    = "kube-proxy"
    version = "v1.31.3-eksbuild.2"
  },
  {
    name    = "aws-ebs-csi-driver"
    version = "v1.38.1-eksbuild.1"
  }
  # Add more addons as needed
]
