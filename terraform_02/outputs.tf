# output "ec2_public_ip" {
#   value = aws_instance.my_instance[*].public_ip
# }

# output "ec2_public_dns" {
#   value = aws_instance.my_instance[*].public_dns
# }

# output "ec2_private_ip" {
#   value = aws_instance.my_instance[*].private_ip
# }

# output "ec2_region" {
#   value = aws_instance.my_instance[*].availability_zone
# }

output "ec2_public_ips" {
  value = {
    for key, instance in aws_instance.my_instance :
    key => instance.public_ip
  }
}

output "ec2_public_dns" {
  value = {
    for key, instance in aws_instance.my_instance :
    key => instance.public_dns
  }
}

output "ec2_private_ips" {
  value = {
    for key, instance in aws_instance.my_instance :
    key => instance.private_ip
  }
}
