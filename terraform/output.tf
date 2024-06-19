#output "jumpbox1_public" {
#  value = digitalocean_droplet.jumpbox1.ipv4_address
#}

output "KUBECONFIG" {
  sensitive = true
  value = digitalocean_kubernetes_cluster.mon_cluster_k8s.kube_config[0].raw_config
}

# https://github.com/Tythos/06-of-52--accessible-kubernetes-with-terraform-and-digitalocean/tree/main doproject

# output "CLUSTER_HOST" {
#   value = digitalocean_kubernetes_cluster.docluster.endpoint
# }

# output "CLUSTER_TOKEN" {
#   value     = digitalocean_kubernetes_cluster.docluster.kube_config[0].token
#   sensitive = true
# }

# output "CLUSTER_CA" {
#   value     = base64decode(digitalocean_kubernetes_cluster.docluster.kube_config[0].cluster_ca_certificate)
#   sensitive = true
# }