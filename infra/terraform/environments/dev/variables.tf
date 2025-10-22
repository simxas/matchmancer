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

variable "master_node_name" {
    type        = string
    description = "Name for the master node"
    default     = "matchmancer-dev-k8s-master"
}

variable "worker_node_name_prefix" {
    type        = string
    description = "Name prefix for the worker node"
    default     = "matchmancer-dev-k8s-worker"
}

variable "load_balancer_name" {
    type        = string
    description = "Name for the load balancer server"
    default     = "matchmancer-dev-load-balancer"
}

variable "labels" {
    type        = map(string)
    description = "Labels for resources"
    default     = {
        environment = "dev"
        project     = "matchmancer"
    }
}