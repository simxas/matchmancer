terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

resource "hcloud_network" "main" {
    name        = var.network_name
    ip_range    = var.network_ip_range
    labels      = var.labels
}

resource "hcloud_network_subnet" "main" {
    network_id    = hcloud_network.main.id
    type          = "cloud"
    network_zone  = var.network_zone
    ip_range      = var.subnet_ip_range
}