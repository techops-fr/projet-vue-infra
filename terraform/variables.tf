
# Le token digitalocean passé par variable d'environnement
# export DO_PAT=xxxxxxxxxxxxxxxxx
# ex: terraform apply --var "do_token=${DO_PAT}" -auto-approve
variable "do_token" {
    type = string
    description = "API token de DigitalOcean - Passé en variable d'env DO_PAT"
}

# La version major/minor de kubernetes à utiliser (cf: doctl kubernetes options versions)
variable k8s_version_prefix { default="1.30." }

# Le nom pour le cluster k8s (visible - seulement caractères alphanumérique minuscules et -)
variable k8s_cluster_name { default="clusterk8s" } 

# La région pour le cluster k8s / et le reseau VPC (si spécifié)
variable do_region { default="ams3" } # cf: doctl kubernetes options regions

# Le réseau privé par defaut pour le cluster K8s
variable do_vpc_cidr { default="10.10.10.0/24" }

# Le nom du pool 
variable pool_name { default="nodes-pool-1" }

# La taille des nodes (cf: doctl kubernetes options sizes)
variable node_size { default = "s-2vcpu-4gb" }

# Le nombre de nodes
variable node_count { default = "3" }
