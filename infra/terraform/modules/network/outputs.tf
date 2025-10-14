output "network_id" {
  description = "Hetzner's ID for the private network"
  value       = hcloud_network.main.id
}

output "network_ip_range" {
  description = "The full network range (like 10.0.0.0/16)"
  value       = hcloud_network.main.ip_range
}

output "subnet_id" {
  description = "Hetzner's ID for the subnet"
  value       = hcloud_network_subnet.main.id
}

output "subnet_ip_range" {
  description = "The subnet range where servers live (like 10.0.1.0/24)"
  value       = hcloud_network_subnet.main.ip_range
}