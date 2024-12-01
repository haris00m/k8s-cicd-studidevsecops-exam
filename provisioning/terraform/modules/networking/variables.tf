# Variables of VPC resources
variable "vpc_name" {}
variable "cidr_block" {}
variable "public_subnet_count" {}
variable "public_subnet_cidrs" {}
variable "availability_zones" {}

# Variables of Security Group resources
variable "sg_name" {}
variable "sg_tags" {}
variable "allowed_cidr_blocks" {}
variable "allowed_ports" {}