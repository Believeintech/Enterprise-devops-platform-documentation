module "vpc" {

  source = "./Modules/vpc"

  vpc_cidr = var.vpc_cidr

  vpc_name = var.vpc_name

}
#################################################################################################################
module "subnets" {

  source = "./Modules/subnets"

  vpc_id = module.vpc.vpc_id

  public_subnet_1_cidr = var.public_subnet_1_cidr

  public_subnet_2_cidr = var.public_subnet_2_cidr

  private_subnet_1_cidr = var.private_subnet_1_cidr

  private_subnet_2_cidr = var.private_subnet_2_cidr

  AZ1 = var.AZ1

  AZ2 = var.AZ2

}

##################################################################################################################################

module "internet_gateway" {

  source = "./Modules/internet_gateway"

  vpc_id = module.vpc.vpc_id

}

################################################################################################################################

module "route_tables" {

  source = "./Modules/route_tables"

  vpc_id = module.vpc.vpc_id

  public_subnet_az1_id = module.subnets.public_subnet_az1_id

  public_subnet_az2_id = module.subnets.public_subnet_az2_id

  internet_gateway_id = module.internet_gateway.internet_gateway_id

}
#####################################################################################################################################
module "security_group" {

  source = "./Modules/security_group"

  vpc_id = module.vpc.vpc_id

}

module "bastion" {

  source = "./Modules/ec2"

  vpc_id = module.vpc.vpc_id

  public_subnet_az1_id = module.subnets.public_subnet_az1_id

  key_pair_name = var.key_pair_name

  public_key_path = var.public_key_path

  instance_type = var.instance_type

  security_group_id = module.security_group.security_group_id

}
