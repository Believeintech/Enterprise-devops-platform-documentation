resource "aws_subnet" "public_az1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = var.AZ1

  tags = {
    Name = "enterprise-devops-public-subnet-az1"
  }
}


resource "aws_subnet" "public_az2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = var.AZ2

  tags = {
    Name = "enterprise-devops-public-subnet-az2"
  }
}

resource "aws_subnet" "private_az1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.AZ1

  tags = {
    Name = "enterprise-devops-private-subnet-az1"
  }
}

resource "aws_subnet" "private_az2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.AZ2

  tags = {
    Name = "enterprise-devops-private-subnet-az2"
  }
}
