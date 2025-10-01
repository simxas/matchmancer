variable "network_name" {
    type        = string
    description = "Name for the private network"
    default     = "matchmancer-dev-network"
}

variable "bastion_server_name" {
    type = string
    description = "Name for the bastion server"
    default = "matchmancer-dev-bastion"
}

variable "labels" {
    type        = map(string)
    description = "Labels for resources"
    default     = {
        environment = "dev"
        project     = "matchmancer"
    }
}