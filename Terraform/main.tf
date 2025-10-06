module "bastion" {
  source               = "./modules/bastion"
  common_resource_name = var.common_resource_name
  vpc_id               = module.network_module.vpc_id
  subnets_details      = module.network_module.subnets
  public_key           = aws_key_pair.public_key_pair
  bastion_sg_id        = module.network_module.bastion_sg_id
}