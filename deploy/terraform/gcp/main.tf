# Custom VPC
resource "google_compute_network" "custom_vpc" {
  name                    = "custom-vpc"
  auto_create_subnetworks = false
}

# Subnet in the VPC
resource "google_compute_subnetwork" "custom_subnet" {
  name          = "custom-subnet"
  ip_cidr_range = "10.10.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.custom_vpc.id
}

# Firewall rule to allow SSH and HTTP
resource "google_compute_firewall" "allow_ssh_http" {
  name    = "allow-ssh-http"
  network = google_compute_network.custom_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "50051"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "cheap_vm" {
  name         = "cheap-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10
    }
  }

  network_interface {
    network    = google_compute_network.custom_vpc.id
    subnetwork = google_compute_subnetwork.custom_subnet.name
    access_config {}
  }

  metadata = {
    ssh-keys = "chat:${file("~/keys/gcp/key.pub")}"
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y curl
    curl -L -o /usr/local/bin/server https://github.com/dulguunb/chatter-go/releases/download/v0.0.1/server
    chmod +x /usr/local/bin/server
    nohup /usr/local/bin/server > /var/log/server.log 2>&1 &
  EOT
}