##############################################################################
# VPC Outputs
##############################################################################

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

##############################################################################
# Subnet Outputs
##############################################################################

output "public_subnet_az1_id" {
  description = "Public Subnet ID in Availability Zone 1"
  value       = module.subnets.public_subnet_az1_id
}

output "public_subnet_az2_id" {
  description = "Public Subnet ID in Availability Zone 2"
  value       = module.subnets.public_subnet_az2_id
}

output "private_subnet_az1_id" {
  description = "Private Subnet ID in Availability Zone 1"
  value       = module.subnets.private_subnet_az1_id
}

output "private_subnet_az2_id" {
  description = "Private Subnet ID in Availability Zone 2"
  value       = module.subnets.private_subnet_az2_id
}

############################################################################
output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = module.internet_gateway.internet_gateway_id
}

###########################################################################

output "public_route_table_id" {
  description = "Public Route Table ID"
  value       = module.route_tables.public_route_table_id
}

#########################################################################
output "security_group_id" {
  description = "Security Group ID"
  value       = module.security_group.security_group_id
}

##############################################################################
# Bastion Outputs
##############################################################################

#output "bastion_instance_id" {
# value = aws_instance.bastion.id
#}

#output "bastion_public_ip" {
# value = aws_instance.bastion.public_ip
#}

#output "bastion_private_ip" {
# value = aws_instance.bastion.private_ip
#}