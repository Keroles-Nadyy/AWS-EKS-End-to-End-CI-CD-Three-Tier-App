output "subnets" {
  value = aws_subnet.subnets
  # sensitive = true
}

output "vpc_id" {
  value = aws_vpc.main.id
  description = "description"
}

output "cidr_block" {
  value = aws_vpc.main.cidr_block
  description = "description"
}

output "eks_cluster_sg_id" {
  value = aws_security_group.eks_cluster_sg.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}