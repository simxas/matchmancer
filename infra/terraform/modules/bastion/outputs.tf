output "bastion_public_ipv4" {
  value       = hcloud_server.bastion.ipv4_address
  description = "The bastion's public IP - this is what you SSH into"
}

output "bastion_private_ip" {
  value       = one(hcloud_server.bastion.network).ip
  description = "The bastion's private IP inside the network"
}

output "bastion_server_id" {
  value       = hcloud_server.bastion.id
  description = "Hetzner's ID for this server"
}

output "bastion_server_name" {
  value       = hcloud_server.bastion.name
  description = "The server's name in Hetzner Cloud"
}