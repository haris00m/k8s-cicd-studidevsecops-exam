output "vpc_id" {
  value = module.networking.vpc_id
}

output "jenkins_server_public_ip" {
  value = module.jenkins-server.ec2_public_ip
}

output "jenkins_agent_1_public_ip" {
  value = module.jenkins-agent-1.ec2_public_ip
}

output "eks_cluster_id" {
  value = module.cluster.cluster_id
}