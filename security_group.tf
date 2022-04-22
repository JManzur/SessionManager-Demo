# Linux instance Security Group
resource "aws_security_group" "linux" {
  name        = "Linux"
  description = "SSH from VPC"
  vpc_id      = var.vpc-id

  ingress {
    description = "SSH from VPC"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  ingress {
    description = "Allow PING"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
  }

  egress {
    description      = "Allow Internet Out"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }

  tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-Linux-SG" }, )
}

# Windows instance Security Group
resource "aws_security_group" "windows" {
  name        = "Windows"
  description = "RDP from VPC"
  vpc_id      = var.vpc-id

  ingress {
    description = "RDP from VPC"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
  }

  ingress {
    description = "Allow PING"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
  }

  egress {
    description      = "Allow Internet Out"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }

  tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-Windows-SG" }, )
}