# Networking variables
variable "vpc_name" {}
variable "cidr_block" {}
variable "public_subnet_count" {}
variable "public_subnet_cidrs" {}
variable "availability_zones" {}

variable "sg_name" {}
variable "sg_tags" {}
variable "allowed_cidr_blocks" {}
variable "allowed_ports" {}

# Instance variables
variable "ami" {}
variable "instance_type" {}
variable "key_pair_name" {}

# Cluster variables
variable "cluster_name" {}
variable "cluster_version" {}

variable "ami_type" {}
variable "desired_capacity" {}
variable "min_capacity" {}
variable "max_capacity" {}
variable "node_instance_type" {}

variable "eks_tags" {}