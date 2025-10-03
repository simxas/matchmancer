variable "environment" {
  type        = string
  description = "Environment (dev, staging, prod)"
}

variable "master_name" {
  type        = string
  description = "Name for the master node"
}

variable "worker_name_prefix" {
  type        = string
  description = "Name prefix for worker nodes"
}

variable "worker_count" {
  type        = number
  description = "Number of worker nodes"
  default     = 2
}

variable "image_name" {
  type        = string
  description = "OS image to use for nodes"
  default     = "ubuntu-24.04"
}

variable "server_type" {
  type        = string
  description = "Server type for all nodes"
  default     = "cx22"
}

variable "location" {
  type        = string
  description = "Datacenter location"
  default     = "fsn1"
}

variable "master_private_ip" {
  type        = string
  description = "Static private IP for master node"
  default     = "10.0.1.10"
}

variable "worker_ip_prefix" {
  type        = string
  description = "IP prefix for worker nodes (will append 1, 2, etc.)"
  default     = "10.0.1.1"
}

variable "private_network_id" {
  type        = string
  description = "ID of the private network"
}

variable "private_network_subnet_id" {
  type        = string
  description = "Subnet ID (for proper dependency ordering)"
}

variable "subnet_ip_range" {
  type        = string
  description = "IP range for the subnet (CIDR format)"
}

variable "bastion_private_ip" {
  type        = string
  description = "Private IP of bastion server for SSH access"
}

variable "ssh_key_name" {
  type        = string
  description = "SSH key name from Hetzner console"
  default     = "wsl_ubuntu"
}

variable "labels" {
  type        = map(string)
  description = "Labels for resources"
}