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

variable "public_subnet_az1_id" {
  description = "ID of the public subnet in AZ1"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}