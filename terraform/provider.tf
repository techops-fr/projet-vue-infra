terraform {
  #required_version = ">= 0.14"
  required_version = ">= 1.8"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.2"
    }
  }
}

# Instance du fournisseur utilisant un token personnel pour l'accès
provider "digitalocean" {
  token = var.do_token
}

# name of ssh key for cluster/droplets
# not necessary if just doing k8s cluster
#data "digitalocean_ssh_key" "terraform" {
#  name = "id_rsa"
#}