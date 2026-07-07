##############################################################################
# Subnet Outputs
##############################################################################

output "public_subnet_az1_id" {
  description = "Public Subnet ID in Availability Zone 1"
  value = aws_subnet.public_az1.id
}

output "public_subnet_az2_id" {
  description = "Public Subnet ID in Availability Zone 2"
  value = aws_subnet.public_az2.id
}

output "private_subnet_az1_id" {
  description = "Private Subnet ID in Availability Zone 1"
  value = aws_subnet.private_az1.id
}

output "private_subnet_az2_id" {
  description = "Private Subnet ID in Availability Zone 2"
  value = aws_subnet.private_az2.id
}