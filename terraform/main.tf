# Pour le positionner dans un projet sur Digital Ocean (optionnel sinon 
# ca sera mis dans le projet par défaut)
resource "digitalocean_project" "mon-projet-k8s" {
  name        = "Projet K8s de test"
  description = "Projet K8S de tests avec nginx Vue.js et MongoDB"
  purpose     = "Web Application Vue"
  environment = "Development" # autre: Production / Staging
  
  # On met le cluster k8s comme ressource dans le projet créé
  resources = [
    digitalocean_kubernetes_cluster.mon_cluster_k8s.urn
  ]
}

# Définir le réseau privé vpc (optionnel) - on peut utiliser le VPC par defaut
resource "digitalocean_vpc" "mon-vpc" {
  name     = "mon-reseau-vpc"
  region   = var.do_region
  ip_range = var.do_vpc_cidr
  # Attente pour le destroy car sinon le VPC contient toujours le cluster - erreur de dependance
  provisioner "local-exec" {
    when    = destroy
    command = "sleep 360"  # Attendez 3min (180s) avant de détruire le VPC
  }

}

# Rechercher la version exacte du k8s disponible
data "digitalocean_kubernetes_versions" "ma-version" {
  version_prefix = var.k8s_version_prefix
}

# Déclaration du cluster
resource "digitalocean_kubernetes_cluster" "mon_cluster_k8s" {
  # Nom du cluster k8s (var)
  name = var.k8s_cluster_name
  # Région de deploiement du cluster k8s (var)
  region = var.do_region
  # Récupérer la dernière version avec prefix "major.minor" depuis `doctl kubernetes options versions`
  version = data.digitalocean_kubernetes_versions.ma-version.latest_version
  # Pour lier le VPC au cluster (optionnel) - on peut utiliser le VPC par defaut
  vpc_uuid = digitalocean_vpc.mon-vpc.id
  # Auto-patch du cluster nouvelle version k8s (optionnel)
  auto_upgrade = false
  # Tags du cluster (optionnel)
  tags = ["tag-k8s"]
  
  # Le node pool principal du cluster (obligatoire)
  node_pool {
    name       = var.pool_name  # voir variables.tf
    size       = var.node_size  # voir variables.tf
    tags       = ["tag-pool"] # optionnel
    # Nombre de nodes fixe
    node_count = var.node_count # voir variables.tf
    auto_scale = false
    # Ou si on veut faire de l'auto scalling
    # auto_scale = true
    # min_nodes  = 2
    # max_nodes  = 5
  }
}

# # On peut créer un autre pool de nodes (optionnel) rattaché au cluster
# # pour par exemple les applications, etc
# resource "digitalocean_kubernetes_node_pool" "app_node_pool" {
#   cluster_id = digitalocean_kubernetes_cluster.mon-cluster-k8s.id
#   name = "application-pool"
#   size = "s-2vcpu-2gb" # avec des instances plus puissantes
#   tags = ["applications"]

#   # Avec de l'autoscalling
#   auto_scale = true
#   min_nodes  = 2
#   max_nodes  = 5
#   labels = {
#     service  = "apps"
#     priority = "high"
#   }
# }

