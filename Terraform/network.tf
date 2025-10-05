module "network_module" {
  source            = "./modules/network"
  vpc_cidr          = var.vpc_cidr
  common_resource_name = var.common_resource_name
  region            = var.region
  subnets_details   = var.subnets_details
}