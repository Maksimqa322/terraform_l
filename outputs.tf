# Output для получения внешнего IP
output "external_ip" {
  value       = yandex_compute_instance.vm.network_interface[0].nat_ip_address
  description = "Внешний IP адрес виртуальной машины"
  sensitive   = false
}

# Output для получения внутреннего IP
output "internal_ip" {
  value       = yandex_compute_instance.vm.network_interface[0].ip_address
  description = "Внутренний IP адрес виртуальной машины"
  sensitive   = false
}

# Output для получения имени VM
output "instance_name" {
  value       = yandex_compute_instance.vm.name
  description = "Имя созданной виртуальной машины"
}

# Output для получения ID VM
output "instance_id" {
  value       = yandex_compute_instance.vm.id
  description = "ID созданной виртуальной машины"
} 