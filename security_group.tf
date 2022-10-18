# Ping Security Group
resource "aws_security_group" "ping" {
  name        = "Allow Ping"
  description = "Ping from VPC"
  vpc_id      = var.vpc-id

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

  tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-Ping-SG" }, )
}