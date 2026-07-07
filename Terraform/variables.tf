variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

##################################################################################################################
variable "public_subnet_1_cidr" {
  description = "CIDR block for the public subnet of 1"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for the public subnet of 2"
  type        = string
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for the private subnet of 1"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for the private subnet of 2"
  type        = string
}

variable "AZ1" {
  description = "Availability zone 1"
  type        = string
}

variable "AZ2" {
  description = "Availability zone 2"
  type        = string
}



######################################################################################################################################
variable "key_pair_name" {
  description = "AWS Key Pair Name"
  type        = string
}


variable "public_key_path" {
  description = "Path to the public SSH key"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}