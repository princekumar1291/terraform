variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"  
}

variable "ec2_root_storage_size" {
  type    = number
  default = 8
}

variable "ec2_ami_id" {
  type    = string
  default = "ami-0f918f7e67a3323f0"
}