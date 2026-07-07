data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

##############################################################################
# AWS Key Pair
##############################################################################

resource "aws_key_pair" "bastion_key" {

  key_name   = var.key_pair_name

  public_key = file(var.public_key_path)

}

##############################################################################
# Bastion Host
##############################################################################

resource "aws_instance" "bastion" {

  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_az1_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_pair_name
  associate_public_ip_address = true

  tags = {
    Name = "Bastion-Host"
  }
}
