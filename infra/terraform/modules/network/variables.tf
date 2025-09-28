variable "environment" {
    type        = string
    description = "Deployment environment"
}

variable "network_name" {
    type        = string
    description = "Name of private network"
}

variable "network_zone" {
  type          = string
  description   = "Network zone for subnet"
  default       = "eu-central"
}

variable "network_ip_range" {
    type        = string
    description = "IP range for private network"
    default     = "10.0.0.0/16"
}

variable "subnet_ip_range" {
    type        = string
    description = "IP range for subnet"
    default     = "10.0.1.0/24"
}

variable "ssh_allowed_ips" {
  type          = list(string)
  description   = "Allowed IPs for SSH access"
}

variable "labels" {
  type          = map(string)
  description   = "Labels for resources"
}