output "load_balancer_id" {
  value       = hcloud_server.load_balancer.id
  description = "Hetzner's ID for this server"
}

output "load_balancer_public_ip" {
  value       = hcloud_server.load_balancer.ipv4_address
  description = "The load balancer's public IP - use for DNS A records"
}

output "load_balancer_private_ip" {
  value       = one(hcloud_server.load_balancer.network).ip
  description = "The load balancer's private IP inside the network"
}

output "load_balancer_name" {
  value       = hcloud_server.load_balancer.name
  description = "The server's name in Hetzner Cloud"
}

output "firewall_id" {
  value       = hcloud_firewall.load_balancer.id
  description = "ID of the load balancer firewall"
}
