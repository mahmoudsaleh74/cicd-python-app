variable "vpc_id" {
    description = "id of vpc"
}

variable "cidr_block" {
    description = "cidr block "
    default = "0.0.0.0/0"
}

variable "igw_id" {
    description = " internet gateway id "
}

variable "rt_name" {
    description = "name tag of rt "
    default = "route table"
}
variable "public_subnet_ids" {
    description = "subnet ids "
    type = list(any)
}



