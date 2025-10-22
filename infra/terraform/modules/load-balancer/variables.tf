variable "environment" {
  type        = string
  description = "Environment (dev, staging, prod)"
}

variable "load_balancer_name" {
  type        = string
  description = "Name for the load balancer server"
}

variable "server_type" {
  type        = string
  description = "Server type/size for load balancer"
  default     = "cx23"
}

variable "image_name" {
  type        = string
  description = "Hetzner Cloud OS image to use"
  default     = "ubuntu-22.04"
}

variable "location" {
  type        = string
  description = "Datacenter location"
  default     = "nbg1"
}

variable "ssh_key_name" {
  type        = string
  description = "SSH key name from Hetzner console"
  default     = "wsl_ubuntu"
}

variable "private_network_id" {
  type        = string
  description = "ID of the private network to join"
}

variable "private_network_subnet_id" {
  type        = string
  description = "Subnet ID (for proper dependency ordering)"
}

variable "load_balancer_private_ip" {
  type        = string
  description = "Static private IP for load balancer"
  default     = "10.0.1.2"
}

variable "bastion_private_ip" {
  type        = string
  description = "Bastion IP for SSH firewall rule"
  default     = "10.0.1.1"
}

variable "labels" {
  type        = map(string)
  description = "Labels for resources"
}
