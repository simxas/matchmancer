output "master_id" {
  description = "ID of the master node"
  value       = hcloud_server.master.id
}

output "master_name" {
  description = "Name of the master node"
  value       = hcloud_server.master.name
}

output "master_private_ip" {
  description = "Private IP of the master node"
  value       = one(hcloud_server.master.network).ip
}

output "worker_ids" {
  description = "IDs of worker nodes"
  value       = hcloud_server.workers[*].id
}

output "worker_names" {
  description = "Names of worker nodes"
  value       = hcloud_server.workers[*].name
}

output "worker_private_ips" {
  description = "Private IPs of worker nodes"
  value       = [for worker in hcloud_server.workers : one(worker.network).ip]
}