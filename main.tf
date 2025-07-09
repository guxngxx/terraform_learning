# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-5"
}

# resource "random_string" "random" {
#   length = 10
# }

# resource "aws_instance" "web" {
#   ami = "ami-02454c79b877e3c97"
#   instance_type = "t3.micro"

#   subnet_id = "subnet-06dd3c17713ca845d"
#   vpc_security_group_ids = ["sg-02f2d9d1daf900579"]

#   tags = {
#   "Terraform" = "true"
#   }
# }

// Lab 4.5 - Terraform Resource Blocks ----------------------------------------------------------------------------------
# resource "aws_s3_bucket" "my-new-S3-bucket" {   
#   bucket = "my-new-tf-test-bucket-${random_id.randomness.hex}"

#   tags = {     
#     Name = "My S3 Bucket"     
#     Purpose = "Intro to Resource Blocks Lab"   
#   } 
# }

# resource "aws_s3_bucket_ownership_controls" "my_new_bucket_ownership_controls" {   
#   bucket = aws_s3_bucket.my-new-S3-bucket.id  
#   rule {     
#     object_ownership = "BucketOwnerPreferred"   
#   }
# }

# resource "aws_security_group" "my-new-security-group" {
#   name        = "web_server_inbound"
#   description = "Allow inbound traffic on tcp/443"
#   vpc_id      = "vpc-0215ae45ecf657527"

#   ingress {
#     description = "Allow 443 from the Internet"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name    = "web_server_inbound"
#     Purpose = "Intro to Resource Blocks Lab"
#   }
# }

# resource "random_id" "randomness" {
#   byte_length = 16
# }

// Lab 4.6 - Introduction to the Terraform Variables Block --------------------------------------------------------------
# resource "aws_subnet" "variables-subnet" {
#   vpc_id                  = "vpc-0215ae45ecf657527"
#   cidr_block              = var.variables_sub_cidr
#   availability_zone       = var.variables_sub_az
#   map_public_ip_on_launch = var.variables_sub_auto_ip

#   tags = {
#     Name      = "sub-variables-${var.variables_sub_az}"
#     Terraform = "true"
#   }
# }

// Lab 4.7 - Introduction to the Terraform Locals Block -----------------------------------------------------------------
// usually local block placed at top
# locals {
#   team        = "api_mgmt_dev"
#   application = "corp_api"
#   server_name = "ec2-${var.environment}-api-${var.variables_sub_az}"
# }

# resource "aws_instance" "web_server" {
#   ami           = "ami-02454c79b877e3c97"
#   instance_type = "t3.micro"
#   subnet_id     = "subnet-06dd3c17713ca845d"
#   tags = {
#     Name = local.server_name
#     Owner = local.team
#     App = local.application
#   }
# }

// Lab 4.8 - Introduction to the Terraform Data Block -------------------------------------------------------------------
# // Retrieve the AWS region
data "aws_region" "current" {}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "data_block_test_vpc"
    Environment = "demo_environment"
    Terraform   = "true"
    Region      = data.aws_region.current.name
  }
}

# // Retrieve the list of AZs in the current AWS region
# data "aws_availability_zones" "available" {}

# # resource "aws_subnet" "private_subnets" {
# #   for_each          = var.private_subnets
# #   vpc_id            = aws_vpc.vpc.id
# #   cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value)
# #   availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]

# #   tags = {
# #     Name      = each.key
# #     Terraform = "true"
# #   }
# # }

# // Terraform Data Block - Lookup Ubuntu 22.04
# data "aws_ami" "ubuntu_22_04" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }

#   owners = ["099720109477"]
# }

# resource "aws_instance" "web_server" {
#   ami                         = data.aws_ami.ubuntu_22_04.id
#   instance_type               = "t3.micro"
#   subnet_id                   = "subnet-06dd3c17713ca845d"
#   associate_public_ip_address = true
#   tags = {
#     Name = "Web EC2 Server"
#   }
# }

// Lab 4.10 - Introduction to the Module Block -------------------------------------------------------------------
#  module "subnet_addrs" {
#   source  = "hashicorp/subnets/cidr"
#   version = "1.0.0"

#   base_cidr_block = "10.0.0.0/22"
#   networks = [
#   {
#     name     = "module_network_a"
#     new_bits = 2
#   },
#   {
#     name     = "module_network_b"
#     new_bits = 2
#   },
#  ]
# }

# output "subnet_addrs" {
#   value = module.subnet_addrs.network_cidr_blocks
# }

