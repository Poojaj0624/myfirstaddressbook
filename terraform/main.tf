terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.17.1"
    }
  }
}

provider "aws" {
  # Configuration options
   access_key = "AKIAXIJ2LJHZNGMJJDY5"
   secret_key = "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"
   region = "us-east-1"
}



# Create a VPC
resource "aws_vpc" "my_vpc" {
  #cidr_block = "10.0.0.0/16"
  cidr_block = var.vpc_cidr_block
  tags = {
    #Name = "my_own_vpc"
    Name = "${var.env}-vpc"
  }
}
module "my_own_module" {

source = "./modules/subnet"
vpc_id = aws_vpc.my_vpc.id
subnet_cidr_block = var.subnet_cidr_block
az = var.az
env = var.env
}

module "my_module_instance" {

source = "./modules/ec2-instance"
vpc_id = aws_vpc.my_vpc.id
subnet_id = module.my_own_module.subnet_details.id
env = var.env
instance_type = var.instance_type
}