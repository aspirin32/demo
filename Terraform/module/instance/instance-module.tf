data "yandex_compute_image" "my_image" {
  family = var.instance_family_image
}


resource "yandex_compute_instance" "vm-sf" {
  name = "vm-sf-${var.instance_family_image}"
  zone = var.zone_name
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
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
