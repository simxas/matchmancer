terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
    http   = {
      source = "hashicorp/http"
      version = "~> 3.0"
    }
  }
}

# Hetzner provider grabs the token from HCLOUD_TOKEN env var
provider "hcloud" {
}

# Figure out our public IP so we can lock down SSH access
data "http" "my_ip" {
  url = "https://ipv4.icanhazip.com"
}

locals {
  environment   = "dev"
  common_labels = {
    project     = "matchmancer"
    environment = local.environment
    managed_by  = "terraform"
  }
  my_ip         = "${trimspace(data.http.my_ip.response_body)}/32"
}

# Set up the private network with NAT routing
module "network" {
  source       = "../../modules/network"
  network_name = var.network_name
  environment  = local.environment
  labels       = local.common_labels
  # bastion_private_ip uses default (10.0.1.1) from the module
}

# Create the bastion - our SSH gateway and NAT box
module "bastion" {
  source                    = "../../modules/bastion"
  bastion_server_name       = var.bastion_server_name
  environment               = local.environment
  private_network_id        = module.network.network_id
  private_network_subnet_id = module.network.subnet_id
  ssh_allowed_ips           = [local.my_ip]
  labels                    = local.common_labels
  # bastion_private_ip uses default (10.0.1.1) from the module
}

# Spin up the k8s cluster - 1 master + 2 workers, all private
module "k8s_cluster" {
  source = "../../modules/k8s-cluster"

  environment                = local.environment
  master_name                = var.master_node_name
  worker_name_prefix         = var.worker_node_name_prefix
  worker_count               = 2
  private_network_id         = module.network.network_id
  private_network_subnet_id  = module.network.subnet_id
  subnet_ip_range            = module.network.subnet_ip_range
  bastion_private_ip         = module.bastion.bastion_private_ip
  load_balancer_private_ip   = module.load_balancer.load_balancer_private_ip
  labels                     = local.common_labels
}

# Create the load balancer - public entry point for web traffic
module "load_balancer" {
  source = "../../modules/load-balancer"

  environment                = local.environment
  load_balancer_name         = var.load_balancer_name
  private_network_id         = module.network.network_id
  private_network_subnet_id  = module.network.subnet_id
  bastion_private_ip         = module.bastion.bastion_private_ip
  labels                     = local.common_labels
  # load_balancer_private_ip uses default (10.0.1.2) from the module
}