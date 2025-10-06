variable "common_resource_name" {
  type        = string
  description = "description"
}

variable "vpc_id" {
    type = string
}

variable "subnets_details" {
  type = any
  description = "description"
}

variable "public_key" {
  description = "Public SSH key to be used for the bastion host"
  type        = string
}

variable "bastion_sg_id" {
  type = string
}
