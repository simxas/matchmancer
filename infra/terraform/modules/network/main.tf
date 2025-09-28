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

resource "hcloud_firewall" "internal" {
    name          = "${var.network_name}-firewall"
    labels        = var.labels

    # for ping
    rule {
        direction   = "in"
        protocol    = "icmp"
        source_ips  = var.environment == "prod" ? var.ssh_allowed_ips : ["0.0.0.0/0", "::/0"]
    }
    
    # ssh access
    rule {
        direction   = "in"
        port        = "22"
        protocol    = "tcp"
        source_ips  = var.ssh_allowed_ips
    }

    # kubectl access
    rule {
        direction   = "in"
        port        = "6443"
        protocol    = "tcp"
        source_ips  = var.ssh_allowed_ips
    }

    # internal
    rule {
        direction   = "in"
        protocol    = "tcp"
        port        = "any"
        source_ips  = [var.subnet_ip_range]
    }

    # internal
    rule {
        direction   = "in"
        protocol    = "udp"
        port        = "any"
        source_ips  = [var.subnet_ip_range]
    }

    # no need for rules for outbound traffic because of how Hetzner cloud works

}