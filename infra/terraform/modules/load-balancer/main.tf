terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

# The load balancer server - public entry point for all web traffic
resource "hcloud_server" "load_balancer" {
  name        = var.load_balancer_name
  server_type = var.server_type
  image       = var.image_name
  location    = var.location
  ssh_keys    = [var.ssh_key_name]
  labels      = var.labels

  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }

  network {
    network_id = var.private_network_id
    ip         = var.load_balancer_private_ip
  }

  firewall_ids = [hcloud_firewall.load_balancer.id]

  depends_on = [var.private_network_subnet_id]
}

# Lock down the load balancer - public HTTP/HTTPS, SSH from bastion only
resource "hcloud_firewall" "load_balancer" {
  name   = "${var.environment}-load-balancer-firewall"
  labels = var.labels

  # Public web traffic on HTTP
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  # Public web traffic on HTTPS
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  # SSH but only from the bastion
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = ["${var.bastion_private_ip}/32"]
  }

  # Ping from private subnet for health checks
  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = ["10.0.1.0/24"]
  }

  # Let it talk to the internet (needs to forward to workers)
  rule {
    direction = "out"
    protocol  = "tcp"
    port      = "any"
    destination_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "out"
    protocol  = "udp"
    port      = "any"
    destination_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "out"
    protocol  = "icmp"
    destination_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}
