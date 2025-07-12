# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-5"
  default_tags {
    tags = {
      Environment = terraform.workspace
    }
  }
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
# data "aws_region" "current" {}

# resource "aws_vpc" "vpc" {
#   cidr_block = "10.0.0.0/16"

#   tags = {
#     Name        = "data_block_test_vpc"
#     Environment = "demo_environment"
#     Terraform   = "true"
#     Region      = data.aws_region.current.name
#   }
# }

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

// Lab 4.15 - Generate SSH Key with Terraform TLS Provider --------------------------------------------------------
# resource "tls_private_key" "generated" {
#   algorithm = "RSA"
# }

# resource "local_file" "private_key_pem" {
#   content  = tls_private_key.generated.private_key_pem
#   filename = "MyAWSKey.pem"
# }

# // Lab 4.17 - Terraform Provisioners ------------------------------------------------------------------------------
# resource "aws_key_pair" "generated" {
#   key_name   = "MyAWSKey"
#   public_key = tls_private_key.generated.public_key_openssh

#   lifecycle {
#     ignore_changes = [key_name]
#   }
# }

# # # Security Groups
# resource "aws_security_group" "ingress-ssh" {
#   name   = "allow-all-ssh"
#   vpc_id = "vpc-0215ae45ecf657527"
#   ingress {
#     cidr_blocks = [
#       "0.0.0.0/0"
#     ]
#     from_port = 22
#     to_port   = 22
#     protocol  = "tcp"
#   }
#   // Terraform removes the default rule
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# Create Security Group - Web Traffic
# resource "aws_security_group" "vpc-web" {
#   name        = "vpc-web-${terraform.workspace}"
#   vpc_id      = "vpc-0215ae45ecf657527"
#   description = "Web Traffic"
#   ingress {
#     description = "Allow Port 80"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "Allow Port 443"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     description = "Allow all ip and ports outbound"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_security_group" "vpc-ping" {
#   name        = "vpc-ping"
#   vpc_id      = "vpc-0215ae45ecf657527"
#   description = "ICMP for Ping Access"
#   ingress {
#     description = "Allow ICMP Traffic"
#     from_port   = -1
#     to_port     = -1
#     protocol    = "icmp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     description = "Allow all ip and ports outbound"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_instance" "ubuntu_server" {
#   ami                         = "ami-02b9fe2e542eec967"
#   instance_type               = "t3.micro"
#   subnet_id                   = "subnet-06dd3c17713ca845d"
#   security_groups             = [aws_security_group.vpc-ping.id, aws_security_group.ingress-ssh.id, aws_security_group.vpc-web.id]
#   associate_public_ip_address = true
#   key_name                    = aws_key_pair.generated.key_name
#   connection {
#     user        = "ubuntu"
#     private_key = tls_private_key.generated.private_key_pem
#     host        = self.public_ip
#   }

#   # Leave the first part of the block unchanged and create our `local-exec` provisioner
#   # provisioner "local-exec" {
#   #   command = "chmod 600 ${local_file.private_key_pem.filename}"
#   # }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo rm -rf /tmp",
#       "sudo git clone https://github.com/hashicorp/demo-terraform-101 /tmp",
#       "sudo sh /tmp/assets/setup-web.sh",
#     ]
#   }

#   tags = {
#     Name = "Ubuntu EC2 Server"
#   }

#   lifecycle {
#     ignore_changes = [security_groups]
#   }

# }

// Lab 5.3 - Terraform Import ------------------------------------------------------------------------------------
# resource "aws_instance" "aws_ubuntu" {
#   ami           = "ami-02b9fe2e542eec967"
#   instance_type = "t3.micro"
# }

// Lab 6.1 - Terraform Modules -----------------------------------------------------------------------------------
# module "server" {
#   source    = "./modules/server"
#   ami       = "ami-02b9fe2e542eec967"
#   subnet_id = "subnet-06dd3c17713ca845d"
#   security_groups = [
#     "sg-02f2d9d1daf900579"
#   ]
# }

# output "public_ip" {
#   value = module.server.public_ip
# }

# output "public_dns" {
#   value = module.server.public_dns
# }

# output "size" {
#   value = module.server.size
# }

// Lab 6.2 - Terraform Module Sources -----------------------------------------------------------------------------------
# module "another_server" {
#   source      = "./modules/web_server"
#   ami         = "ami-02b9fe2e542eec967"
#   key_name    = aws_key_pair.generated.key_name
#   user        = "ubuntu"
#   private_key = tls_private_key.generated.private_key_pem
#   subnet_id   = "subnet-06dd3c17713ca845d"
#   security_groups = [
#     aws_security_group.vpc-ping.id,
#     aws_security_group.ingress-ssh.id,
#     aws_security_group.vpc-web.id
#   ]
# }

# output "another_public_ip" {
#   value = module.another_server.public_ip
# }

# output "another_public_dns" {
#   value = module.another_server.public_dns
# }

# module "autoscaling" {
#   source  = "terraform-aws-modules/autoscaling/aws"
#   version = "9.0.1"

#   # Autoscaling group
#   name = "myasg"

#   vpc_zone_identifier = ["subnet-06dd3c17713ca845d"]
#   min_size            = 0
#   max_size            = 1
#   desired_capacity    = 1

#   # Launch template
#   image_id      = "ami-02b9fe2e542eec967"
#   instance_type = "t3.micro"
#   instance_name = "asg-instance"

#   tags = {
#     Name = "Web EC2 Server 2"
#   }
# }

// Lab 6.5 - Terraform Modules - Public Module Registry -----------------------------------------------------------------
# module "s3-bucket" {
#   source  = "terraform-aws-modules/s3-bucket/aws"
#   version = "5.2.0"
# }

# output "s3_bucket_name" {
#   value = module.s3-bucket.s3_bucket_bucket_domain_name
# }

// Lab 9.6 - Terraform Collections and Structure Types ------------------------------------------------------------------
// create 1 subnet only
resource "aws_subnet" "list_subnet1" {
  vpc_id     = "testing123"
  cidr_block = var.ip["prod"]
  // cidr_block     = var.ip[var.environment]
  availability_zone = var.us-east-1-azs[0]
}

// create 2 subnets because "for_each" loop 2 items in var.ip
resource "aws_subnet" "list_subnet2" {
  for_each          = var.ip
  vpc_id            = "testing123"
  cidr_block        = each.value
  availability_zone = var.us-east-1-azs[0]
}

// create 2 subnets because "for_each" loop 2 items in var.env
resource "aws_subnet" "list_subnet3" {
  for_each          = var.env
  vpc_id            = "testing123"
  cidr_block        = each.value.ip
  availability_zone = each.value.az
}

// Lab 9.7 - Working with Data Blocks -----------------------------------------------------------------------------------
data "aws_s3_bucket" "data_bucket" {
  bucket = "my-data-lookup-bucket-btk"
}

resource "aws_iam_policy" "policy" {
  name        = "data_bucket_policy"
  description = "Allow access to my bucket"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:Get*",
          "s3:List*"
        ],
        "Resource" : "${data.aws_s3_bucket.data_bucket.arn}"
      }
    ]
  })
}

output "data-bucket-arn" {
  value = data.aws_s3_bucket.data_bucket.arn
}

output "data-bucket-domain-name" {
  value = data.aws_s3_bucket.data_bucket.bucket_domain_name
}

output "data-bucket-region" {
  value = "The ${data.aws_s3_bucket.data_bucket.id} bucket is located in ${data.aws_s3_bucket.data_bucket.region}"
}