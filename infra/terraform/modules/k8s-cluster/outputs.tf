output "master_id" {
  description = "Hetzner's ID for the master node"
  value       = hcloud_server.master.id
}

output "master_name" {
  description = "The master node's hostname"
  value       = hcloud_server.master.name
}

output "master_private_ip" {
  description = "Where to reach the master on the private network"
  value       = one(hcloud_server.master.network).ip
}

output "worker_ids" {
  description = "Hetzner IDs for all the workers"
  value       = hcloud_server.workers[*].id
}

output "worker_names" {
  description = "Hostnames of all the worker nodes"
  value       = hcloud_server.workers[*].name
}

output "worker_private_ips" {
  description = "Private IPs where the workers live"
  value       = [for worker in hcloud_server.workers : one(worker.network).ip]
}