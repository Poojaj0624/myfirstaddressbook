#create a security group
resource "aws_security_group" "my_sec_grp" {
  name        = "my_own_sec_grp"
  description = "Allow SSH,http,ICMP traffic"
  #vpc_id      = aws_vpc.my_vpc.id
  vpc_id = var.vpc_id
  ingress {
    description      = "HTTP"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    #Name = "my_own_sg"
    Name = "${var.env}-sec_grp"
  }
}

data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
#create ec2 instance
resource "aws_instance" "my_instance" {
  #ami = "ami-0022f774911c1d690"
  ami = data.aws_ami.latest-amazon-linux-image.id
  #instance_type = "t2.micro"
  instance_type = var.instance_type
  associate_public_ip_address = true
  #subnet_id = aws_subnet.my_subnet.id
  #subnet_id = module.my_own_module.subnet_details.id
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.my_sec_grp.id]
  key_name = "KeyPair"
  user_data = file("server-script.sh")
  #user_data = <<-EOF
  ##!/bin/bash
  #sudo yum install httpd -y
  #sudo systemctl start httpd
  #sudo systemctl enable httpd
  #EOF

  tags = {
    #Name = "my_own_instance"
    Name = "${var.env}-my_instance"
  }
}

