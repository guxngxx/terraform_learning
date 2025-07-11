// Lab 6.3 - Terraform Modules Inputs and Outputs ------------------------------------------------------------------------
variable "ami" {}
variable "size" {
  default = "t3.micro"
}
variable "subnet_id" {}
variable "security_groups" {
  type = list(any)
}