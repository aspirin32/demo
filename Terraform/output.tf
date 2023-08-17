# внутренний адрес виртуалки 1
output "internal_ip_address_vm_1" {
  value = module.instance_1.internal_ip_address_vm
}
# внешний адрес виртуалки 1
output "external_ip_address_vm_1" {
  value = module.instance_1.external_ip_address_vm
}
# внутренний адрес виртуалки 2
output "internal_ip_address_vm_2" {
  value = module.instance_2.internal_ip_address_vm
}
# внешний адрес виртуалки 1
output "external_ip_address_vm_2" {
  value = module.instance_2.external_ip_address_vm
}
