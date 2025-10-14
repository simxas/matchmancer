terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

# The k8s master node - runs the control plane, no public IP
resource "hcloud_server" "master" {
  name        = var.master_name
  image       = var.image_name
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [var.ssh_key_name]
  labels      = var.labels

  public_net {
    ipv4_enabled = false
    ipv6_enabled = false
  }

  network {
    network_id = var.private_network_id
    ip         = var.master_private_ip
  }

  firewall_ids = [hcloud_firewall.master.id]

  depends_on = [var.private_network_subnet_id]
}

# The k8s worker nodes - where our apps actually run
resource "hcloud_server" "workers" {
  count       = var.worker_count
  name        = "${var.worker_name_prefix}-${count.index + 1}"
  image       = var.image_name
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [var.ssh_key_name]
  labels      = var.labels

  public_net {
    ipv4_enabled = false
    ipv6_enabled = false
  }

  network {
    network_id = var.private_network_id
    ip         = "${var.worker_ip_prefix}${count.index + 1}"
  }

  firewall_ids = [hcloud_firewall.workers.id]

  depends_on = [var.private_network_subnet_id]
}

# Master firewall - keep it locked down tight
resource "hcloud_firewall" "master" {
  name   = "${var.master_name}-firewall"
  labels = var.labels

  # SSH but only from the bastion
  rule {
    direction  = "in"
    port       = "22"
    protocol   = "tcp"
    source_ips = ["${var.bastion_private_ip}/32"]
  }

  # Kubernetes API - bastion needs this for kubectl access
  rule {
    direction  = "in"
    port       = "6443"
    protocol   = "tcp"
    source_ips = ["${var.bastion_private_ip}/32"]
  }

  # Let all the k8s nodes talk to each other freely
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "any"
    source_ips = [var.subnet_ip_range]
  }

  rule {
    direction  = "in"
    protocol   = "udp"
    port       = "any"
    source_ips = [var.subnet_ip_range]
  }

  # Ping between nodes is handy for debugging
  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = [var.subnet_ip_range]
  }
}

# Worker firewall - these will also need to accept load balancer traffic later
resource "hcloud_firewall" "workers" {
  name   = "${var.worker_name_prefix}-firewall"
  labels = var.labels

  # SSH but only from the bastion
  rule {
    direction  = "in"
    port       = "22"
    protocol   = "tcp"
    source_ips = ["${var.bastion_private_ip}/32"]
  }

  # Let all the k8s nodes talk to each other freely
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "any"
    source_ips = [var.subnet_ip_range]
  }

  rule {
    direction  = "in"
    protocol   = "udp"
    port       = "any"
    source_ips = [var.subnet_ip_range]
  }

  # Ping between nodes is handy for debugging
  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = [var.subnet_ip_range]
  }
}