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

# provider configuration - will automatically use HCLOUD_TOKEN env var
provider "hcloud" {
  # token is read from HCLOUD_TOKEN environment variable
}

# auto-detect my current public IP
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

# use the network module
module "network" {
  source            = "../../modules/network"
  network_name      = var.network_name
  environment       = local.environment
  labels            = local.common_labels
}

# use bastion module
module "bastion" {
  source = "../../modules/bastion"
  bastion_server_name = var.bastion_server_name
  environment = local.environment
  private_network_id = module.network.network_id
  private_network_subnet_id = module.network.subnet_id
  ssh_allowed_ips = [local.my_ip]
  labels = local.common_labels
}