# resource "random_string" "random" {
#   length = 10
# }

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-5"
}

resource "aws_instance" "web" {
  ami = "ami-02454c79b877e3c97"
  instance_type = "t3.micro"

  subnet_id = "subnet-06dd3c17713ca845d"
  vpc_security_group_ids = ["sg-02f2d9d1daf900579"]

  tags = {
  "Terraform" = "true"
  }
}