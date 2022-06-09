output "ec2-ip" {
  value = module.my_module_instance.instance_details.public_ip
  #value = aws_instance.my_instance.public_ip
}

output "ami-id" {
  value = module.my_module_instance.instance_details.ami
  #value = data.aws_ami.latest-amazon-linux-image.id

}