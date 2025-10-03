output "network_id" {
  description = "ID of the private network"
  value       = module.network.network_id
}

output "dev_bastion_public_ipv4" {
  description = "Public IPv4 of the bastion server"
  value       = module.bastion.bastion_public_ipv4
}

output "dev_bastion_private_ipv4" {
  description = "Private IP of the bastion server"
  value       = module.bastion.bastion_private_ip
}

output "dev_bastion_server_name" {
  description = "Name of the bastion server"
  value       = module.bastion.bastion_server_name
}

output "dev_bastion_server_id" {
  description = "ID of the bastion server"
  value       = module.bastion.bastion_server_id
}

output "k8s_master_private_ip" {
  description = "Private IP of K8s master node"
  value       = module.k8s_cluster.master_private_ip
}

output "k8s_worker_private_ips" {
  description = "Private IPs of K8s worker nodes"
  value       = module.k8s_cluster.worker_private_ips
}