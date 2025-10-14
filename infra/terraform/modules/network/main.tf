terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

# Our private network where all the servers will hang out
resource "hcloud_network" "main" {
    name        = var.network_name
    ip_range    = var.network_ip_range
    labels      = var.labels
}

# Carve out a subnet for our servers to use
resource "hcloud_network_subnet" "main" {
    network_id    = hcloud_network.main.id
    type          = "cloud"
    network_zone  = var.network_zone
    ip_range      = var.subnet_ip_range
}

# Tell the network to send all internet traffic through the bastion
# This lets our private k8s nodes reach the internet without being exposed
resource "hcloud_network_route" "nat_gateway" {
    network_id      = hcloud_network.main.id
    destination     = "0.0.0.0/0"
    gateway         = var.bastion_private_ip

    depends_on = [
        hcloud_network_subnet.main
    ]
}