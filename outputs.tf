// Lab 4.11 - Introduction to the Terraform Output Block -----------------------------------------------------------------
output "hello-world" {
  description = "Print a Hello World text output"
  value       = "Hello World. Environment: ${terraform.workspace}"
}

# output "vpc_id" {
#   description = "Output the ID for the primary VPC"
#   value       = aws_vpc.vpc.id
# }

# output "public_url" {
#   description = "Public URL for our Web Server"
#   value = "https://${aws_instance.web_server.public_ip}:8080/index.html"
# }

# output "vpc_information" {
#   description = "VPC Information about Environment"
#   value       = "Your ${aws_vpc.vpc.tags.Environment} VPC has an ID of ${aws_vpc.vpc.id}"
# }