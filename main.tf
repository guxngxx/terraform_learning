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
resource "aws_subnet" "variables-subnet" {
  vpc_id                  = "vpc-0215ae45ecf657527"
  cidr_block              = var.variables_sub_cidr
  availability_zone       = var.variables_sub_az
  map_public_ip_on_launch = var.variables_sub_auto_ip

  tags = {
    Name      = "sub-variables-${var.variables_sub_az}"
    Terraform = "true"
  }
}