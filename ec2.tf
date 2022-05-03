# Grabbing latest Linux 2 AMI
data "aws_ami" "linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Grabbing latest Windows Server 2019
data "aws_ami" "win2022" {
  most_recent = true
  owners      = ["801119661308"]

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#EC2 IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "AppConfigPOCInstanceProfile"
  role = aws_iam_role.ec2_policy_role.name
}

# Linux EC2 Instance
resource "aws_instance" "linux" {
  count = var.CreateLinux ? 1 : 0 #If CreateLinux == "true", then create 1 instance, else do nothing
  ami                    = data.aws_ami.linux2.id
  instance_type          = var.instance_type["type1"]
  subnet_id              = var.private-subnet-id
  key_name               = var.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  user_data = <<EOF
  #!/bin/bash
  yum update -y
  yum install telnet -y
  Date=$(date +%m/%d/%Y)
  Time=$(date +%H:%M:%S)
  echo "Hello from SSM Session Manager at $Date $Time" >> /tmp/hello.txt
  EOF

  tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-Linux" }, )

  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
    tags                  = merge(var.project-tags, { Name = "${var.resource-name-tag}-Linux-EBS" }, )
  }
}

# Windows EC2 Instance
resource "aws_instance" "windows" {
  count = var.CreateWindows ? 1 : 0 #If CreateWindows == "true", then create 1 instance, else do nothing
  ami                    = data.aws_ami.win2022.id
  instance_type          = var.instance_type["type1"]
  subnet_id              = var.private-subnet-id
  key_name               = var.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  user_data = <<EOF
  <powershell>
  Install-WindowsFeature Telnet-Client
  mkdir C:\temp
  Write-Output "Hello from SSM Session Manager at $(Get-Date)" >> C:\tmp\hello.txt
  </powershell>
  EOF

  tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-Windows" }, )

  root_block_device {
    volume_size           = 100
    volume_type           = "gp2"
    delete_on_termination = true
    tags                  = merge(var.project-tags, { Name = "${var.resource-name-tag}-Windows-EBS" }, )
  }
}

output "Linux_Instance_ID" {
  description = "The Linux EC2 instance ID"
  value       = aws_instance.linux[count.index].id
}

output "Windows_Instance_ID" {
  description = "The Windows EC2 instance ID"
  value       = aws_instance.windows[count.index].id
}