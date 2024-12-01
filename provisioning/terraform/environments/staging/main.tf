module "networking" {
  source              = "../../modules/networking"
  vpc_name            = var.vpc_name
  cidr_block          = var.cidr_block
  public_subnet_count = var.public_subnet_count
  public_subnet_cidrs = var.public_subnet_cidrs
  availability_zones  = var.availability_zones

  sg_name             = var.sg_name
  sg_tags             = var.sg_tags
  allowed_cidr_blocks = var.allowed_cidr_blocks
  allowed_ports       = var.allowed_ports
}

module "jenkins-server" {
  source            = "../../modules/instance"
  ami               = var.ami
  instance_type     = var.instance_type
  key_pair_name     = var.key_pair_name
  subnet_id         = module.networking.public_subnets[0]
  security_group_id = module.networking.security_group_id
  instance_tag_names = {
    Name = "jenkins-server"
    Role = "master"
  }
}

module "jenkins-agent-1" {
  source            = "../../modules/instance"
  ami               = var.ami
  instance_type     = var.instance_type
  key_pair_name     = var.key_pair_name
  subnet_id         = module.networking.public_subnets[1]
  security_group_id = module.networking.security_group_id
  instance_tag_names = {
    Name = "jenkins-agent-1"
    Role = "agent"
  }
}

module "cluster" {
  source             = "../../modules/cluster"
  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  subnets            = module.networking.public_subnets
  ami_type           = var.ami_type
  desired_capacity   = var.desired_capacity
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  node_instance_type = var.node_instance_type
  eks_tags           = var.eks_tags
}