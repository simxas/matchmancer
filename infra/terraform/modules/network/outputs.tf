output "network_id" {
  description = "ID of the created network"
  value       = hcloud_network.main.id
}

output "network_ip_range" {
  description = "IP range of the network"
  value       = hcloud_network.main.ip_range
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = hcloud_network_subnet.main.id
}

output "firewall_id" {
  description = "ID of the internal firewall"
  value       = hcloud_firewall.internal.id
}