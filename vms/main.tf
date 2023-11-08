# PROJECT NAME: vmspiner v1.0
#____________________________________________________
# PROJECT DESCRIPTION : VM EC2 Spinner: 
#____________________________________________________
# This file contains the main resources of the vm module
# Author: Kennedy .N
#____________________________________________________

#_________MODULE::::::Main____________

#____________________________________________________

# Declare local Variables
locals {
  http_port    = 80
  any_port     = 0
  ssh_port     = 22
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}

# configured aws provider with proper credentials


# create default vpc if one does not exit
# resource "aws_default_vpc" "default_vpc" {

#   tags = {
#     Name = "default vpc"
#   }
# }


# # use data source to get all avalablility zones in region
# data "aws_availability_zones" "available_zones" {}


# # create default subnet if one does not exit
# resource "aws_default_subnet" "default_az1" {
#   availability_zone = data.aws_availability_zones.available_zones.names[0]

#   tags = {
#     Name = "default subnet"
#   }
# }




data "aws_subnets" "snetids" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.lookup.id]
  }
}


output "out_snetid" {
  value=data.aws_subnets.snetids.ids[0]
}

data "aws_vpc" "lookup" {

  
  tags = {
    Name = var.vpc_network_name
  }
  
}

data "aws_availability_zones" "available_zones" {}


# create security group for the ec2 instance
resource "aws_security_group" "ec2_security_group" {
  name        = var.aws_sg_group
  description = "allow access on all ports"
    #vpc_id      = aws_default_vpc.default_vpc.id
  #vpc_id= data.aws_vpc.lookup.id
  vpc_id      = data.aws_vpc.lookup.id
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.aws_sg_group
  }
}



# launch the ec2 instance and install website
resource "aws_instance" "ec2_instance" {
  ami                    = var.image
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnets.snetids.ids[0]
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  key_name               = aws_key_pair.ssh_key.key_name
  user_data = file(var.startupscript)
  associate_public_ip_address = true
  #user_data = "${file("startup.sh")}"
  tags = {
    Name = var.tagg
  }



    
}

resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# creating the keypair in aws
resource "aws_key_pair" "ssh_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ec2_key.public_key_openssh 
}

# Save the .pem file locally for remote connection
resource "local_file" "ssh_key" {
 
  filename ="${var.key_name}.pem" 
  content  = tls_private_key.ec2_key.private_key_pem
}