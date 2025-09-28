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

# Provider configuration - will automatically use HCLOUD_TOKEN env var
provider "hcloud" {
  # Token is read from HCLOUD_TOKEN environment variable
}

# Auto-detect my current public IP
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

# Use the network module
module "network" {
  source            = "../../modules/network"
  network_name      = var.network_name
  environment       = local.environment
  ssh_allowed_ips   = [local.my_ip]  # Uses auto-detected IP
  labels            = local.common_labels
}