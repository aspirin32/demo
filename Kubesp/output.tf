# внутренний адрес k8s-master
output "internal_ip_k8s-master" {
  value = module.k8s-master.internal_ip_address_vm
}
# внешний адрес k8s-master
output "k8s-master" {
  value = module.k8s-master.external_ip_address_vm
}
# внутренний адрес k8s-worker
output "internal_ip_k8s-worker" {
  value = module.k8s-worker.internal_ip_address_vm
}

# внешний адрес k8s-worker
output "k8s-worker" {
  value = module.k8s-worker.external_ip_address_vm
}
# внутренний адрес srv
#output "internal_ip_srv" {
#  value = module.srv.internal_ip_address_vm
#}
# внешний адрес srv
output "srv" {
  value = module.srv.external_ip_address_vm
}
#внутренний адрес ansible-master
output "internal_ip_srv" {
  value = module.ansible-master.internal_ip_address_vm
}
# внешний адрес ansible-master
output "ansible-master" {
  value = module.ansible-master.external_ip_address_vm
}
