# EKS Variables
variable "cluster_name" {}
variable "cluster_version" {}
variable "subnets" {}

# Node Group Variables
variable "ami_type" {}
variable "desired_capacity" {}
variable "min_capacity" {}
variable "max_capacity" {}
variable "node_instance_type" {}

variable "eks_tags" {}