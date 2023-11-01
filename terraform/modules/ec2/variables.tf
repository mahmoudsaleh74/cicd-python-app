variable "instance_type" {
    description = "type for ec2"
    default = "t2.micro" 
}
variable "availability_zone" {
    description = "availabilty zone for ec2"
    default = "us-east-1a"
  
}

variable "subnet_id" {
    description = "subnet for ec2"
  
}

variable "sg" {
    description = "sg for ec2"
  
}

variable "volume_size" {
    description = "ebs size for ec2"
    default = "8"
  
}
variable "volume_type" {
    description = "ebs type for ec2"
    default = "gp2"
}
variable "instance_name" {
    description = " name tage for ec2"
    default = "instance terraform"
}

variable "key_pair_name" {
  description = "The name of the key pair for SSH access to the EC2 instance."
  default = "kamen"
}
variable "eks_profile_name" {
  description = "The Name of Eks Profile Name where the EC2 instance will be launched."
}