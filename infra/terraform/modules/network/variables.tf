variable "environment" {
    type        = string
    description = "Environment (dev, staging, prod)"
}

variable "network_name" {
    type        = string
    description = "Name for the private network"
}

variable "network_zone" {
  type          = string
  description   = "Hetzner network zone for the subnet"
  default       = "eu-central"
}

variable "network_ip_range" {
    type        = string
    description = "IP range for the network (CIDR format)"
    default     = "10.0.0.0/16"
}

variable "subnet_ip_range" {
    type        = string
    description = "IP range for the subnet (CIDR format)"
    default     = "10.0.1.0/24"
}

variable "bastion_private_ip" {
  type        = string
  description = "Private IP of bastion server for NAT gateway routing"
  default     = "10.0.1.1"
}

variable "labels" {
  type          = map(string)
  description   = "Labels for resources"
}