variable "cluster_name" {
  description = "The name of the EKS cluster."
  default = "master"
}

variable "node_group_name" {
  description = "The name of the node group name."
  default = "node group"
}

variable "worker_template" {
  description = "The name of the Worker Template."
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the EKS cluster."
  type        = list(string)
}

variable "security_group" {
  description = "The ID Of Security Group"
}

variable "disk_size" {
  description = "node group disk size"
  default = "5"
}

variable "instance_type" {
  description = "node group instance type"
  default = "t2.micro"
}

variable "ssh_key" {
  description = "node group ssh key"
  default = "kamen"
}

variable "scaling" {
  type = list(any)
  description = "desired , max , min instances for scaling"
  default = [1,2,1]
}