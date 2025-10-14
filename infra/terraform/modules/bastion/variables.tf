variable "bastion_server_name" {
    type        = string
    description = "Name for the bastion server"
    default     = "bastion"
}

variable "environment" {
  type        = string
  description = "Environment (dev, staging, prod)"
}

variable "bastion_image_name" {
  type        = string
  description = "Hetzner Cloud OS image to use for bastion"
  default     = "ubuntu-24.04"
}

variable "bastion_server_type" {
  type        = string
  description = "Server type/size for bastion"
  default     = "cx22"
}

variable "bastion_server_location" {
  type        = string
  description = "Datacenter location"
  default     = "fsn1"
}

variable "private_network_id" {
    type        = string
    description = "ID of the private network to attach bastion to"
}

variable "private_network_subnet_id" {
  type        = string
  description = "Subnet ID (for proper dependency ordering)"
}

variable "bastion_private_ip" {
  type        = string
  description = "Static private IP for bastion server (NAT gateway)"
  default     = "10.0.1.1"
}

variable "ssh_key_name" {
  type        = string
  description = "SSH key name from Hetzner console"
  default     = "wsl_ubuntu"
}

variable "ssh_allowed_ips" {
  type        = list(string)
  description = "IPs allowed to SSH into bastion (CIDR format)"
}

variable "labels" {
  type          = map(string)
  description   = "Labels for resources"
}