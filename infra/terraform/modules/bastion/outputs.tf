# infra/terraform/modules/bastion/outputs.tf

output "bastion_public_ipv4" {
  value       = hcloud_server.bastion.ipv4_address
  description = "Public IPv4 address of the bastion server"
}

output "bastion_private_ip" {
  value       = one(hcloud_server.bastion.network).ip
  description = "Private IP address of the bastion server"
}

output "bastion_server_id" {
  value       = hcloud_server.bastion.id
  description = "ID of the bastion server"
}

output "bastion_server_name" {
  value       = hcloud_server.bastion.name
  description = "Name of the bastion server"
}