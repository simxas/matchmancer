output "network_id" {
  description = "ID of the private network"
  value       = hcloud_network.main.id
}

output "network_ip_range" {
  description = "IP range of the network"
  value       = hcloud_network.main.ip_range
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = hcloud_network_subnet.main.id
}

output "subnet_ip_range" {
  description = "IP range of the subnet"
  value       = hcloud_network_subnet.main.ip_range 
}