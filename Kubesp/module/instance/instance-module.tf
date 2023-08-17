data "yandex_compute_image" "my_image" {
  family = var.instance_family_image
}


resource "yandex_compute_instance" "vm-sf" {
  name = "vm-sf-${var.module_name}"
  zone = var.zone_name
  resources {
    core_fraction = 20
    cores  = 2
    memory = 4
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
      size     = 20
    }
  }
  network_interface {
    nat       = true
    subnet_id = var.subnet_mtfk
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
