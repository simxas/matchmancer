terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

# bastion server
resource "hcloud_server" "bastion" {
  name        = var.bastion_server_name
  image       = var.bastion_image_name
  server_type = var.bastion_server_type
  location    = var.bastion_server_location
  labels      = var.labels

  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }

  network {
    network_id = var.private_network_id
  }

  firewall_ids  = [hcloud_firewall.bastion.id]

  depends_on    = [
    var.private_network_subnet_id
  ]

  ssh_keys      = [var.ssh_key_name]
}

resource "hcloud_firewall" "bastion" {
    name            = "${var.bastion_server_name}-firewall"
    labels          = var.labels

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
}