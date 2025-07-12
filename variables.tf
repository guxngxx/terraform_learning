// Lab 4.6 - Introduction to the Terraform Variables Block --------------------------------------------------------------
variable "variables_sub_cidr" {
  description = "CIDR Block for the Variables Subnet"
  type        = string
  default     = "172.31.48.0/20"
}

variable "variables_sub_az" {
  description = "Availability Zone used Variables Subnet"
  type        = string
  default     = "ap-southeast-5a"
}

variable "variables_sub_auto_ip" {
  description = "Set Automatic IP Assignment for Variables Subnet"
  type        = bool
  default     = true
}

// Lab 4.7 - Introduction to the Terraform Locals Block -----------------------------------------------------------------
variable "environment" {
  description = "Environment for deployment"
  type        = string
  default     = "dev"
}

// Lab 9.6 - Terraform Collections and Structure Types ------------------------------------------------------------------
variable "ip" {
  type = map(string)
  default = {
    prod = "10.0.150.0/24"
    dev  = "10.0.250.0/24"
  }
}

variable "us-east-1-azs" {
  type = list(string)
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
    "us-east-1e"
  ]
}

variable "env" {
  type = map(any)
  default = {
    prod = {
      ip = "10.0.150.0/24"
      az = "us-east-1a"
    }
    dev = {
      ip = "10.0.250.0/24"
      az = "us-east-1e"
    }
  }
}

// Lab 9.8 - Terraform Built-in Functions --------------------------------------------------------------------------------
variable "num_1" {
  type        = number
  description = "Numbers for function labs"
  default     = 88
}

variable "num_2" {
  type        = number
  description = "Numbers for function labs"
  default     = 73
}

variable "num_3" {
  type        = number
  description = "Numbers for function labs"
  default     = 52
}

// Lab 9.9 - Dynamic Blocks ----------------------------------------------------------------------------------------------
variable "web_ingress" {
  type = map(object(
    {
      description = string
      port        = number
      protocol    = string
      cidr_blocks = list(string)
    }
  ))
  default = {
    "80" = {
      description = "Port 80"
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    "443" = {
      description = "Port 443"
      port        = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}