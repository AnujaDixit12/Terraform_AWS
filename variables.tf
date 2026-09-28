variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet1_cidr" {
  default = "10.0.1.0/24"
}

variable "subnet2_cidr" {
  default = "10.0.2.0/24"
}

variable "ec2_instance_type" {
    
    default = "t3.micro"
    type = string
}

variable "ec2_ami_id" {

    default = "ami-0e5497a77ef21b5ac"
    type = string
  
}

variable "ec2_root_volume" {

    default = 8
    type = number
  
}