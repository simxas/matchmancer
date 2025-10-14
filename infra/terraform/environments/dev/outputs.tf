output "network_id" {
  description = "The private network ID if you need it"
  value       = module.network.network_id
}

output "dev_bastion_public_ipv4" {
  description = "SSH into this IP to reach your infrastructure"
  value       = module.bastion.bastion_public_ipv4
}

output "dev_bastion_private_ipv4" {
  description = "The bastion's IP inside the private network"
  value       = module.bastion.bastion_private_ip
}

output "dev_bastion_server_name" {
  description = "The bastion's hostname"
  value       = module.bastion.bastion_server_name
}

output "dev_bastion_server_id" {
  description = "Hetzner's ID for the bastion"
  value       = module.bastion.bastion_server_id
}

output "k8s_master_private_ip" {
  description = "Where the k8s master lives (use this for kubectl)"
  value       = module.k8s_cluster.master_private_ip
}

output "k8s_worker_private_ips" {
  description = "The worker IPs (load balancer will target these)"
  value       = module.k8s_cluster.worker_private_ips
}