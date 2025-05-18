terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.35.0"
    }
  }
}
provider "google" {
  credentials = file("")
  project     = "chatter-f9453"
  region      = "us-central1"
  zone        = "us-central1-a"
}