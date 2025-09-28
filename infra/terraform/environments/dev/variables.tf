variable "network_name" {
    type        = string
    description = "My private network name"
    default     = "matchmancer-dev-network"
}

variable "labels" {
    type        = map(string)
    description = "Labels for my resources"
    default     = {
        environment = "dev"
        project     = "matchmancer"
    }
}