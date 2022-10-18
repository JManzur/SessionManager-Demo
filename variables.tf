# AWS Region: North of Virginia
variable "aws_region" {
  type = string
}

# AWS Region: North of Virginia
variable "aws_profile" {
  type = string
}

/* EC2 Instance type */
#Use: instance_type = var.instance_type["type1"]
variable "instance_type" {
  type = map(string)
  default = {
    "type1" = "t2.micro"
    "type2" = "t2.small"
    "type3" = "t2.medium"
  }
}

# SSH Key-Pair 
variable "key_name" {
  type = string
}

/* Tags Variables */
# Use: tags  = merge(var.project-tags, { Name = "${var.resource-name-tag}-XYZ" }, )
variable "project-tags" {
  type = map(string)
  default = {
    service     = "SSM-Demo",
    environment = "POC"
  }
}

variable "resource-name-tag" {
  type    = string
  default = "SSM-Demo"
}

variable "vpc-id" {
  type = string
}

variable "private-subnet-id" {
  type = string
}

variable "CreateLinux" {
  type    = bool
  default = "false"
}

variable "CreateWindows" {
  type    = bool
  default = "true"
}