terraform {
  required_version = "= v1.4.2"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.86.0"
    }
  }
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tfstate-aspirin"
    region     = "ru-central1-a"
    key        = "state-file-modules/modules-state.tfstate"
    access_key = "-"
    secret_key = "-"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
provider "yandex" {
  token     = "-"
  cloud_id  = "-"
  folder_id = "-"
}

resource "yandex_lb_target_group" "lb_sf_vm" {
  name      = "sf-target-group"
  region_id = "ru-central1"

  target {
    subnet_id = yandex_vpc_subnet.subnet_1.id
    address   = module.instance_1.internal_ip_address_vm
  }
  target {
    subnet_id = yandex_vpc_subnet.subnet_2.id
    address   = module.instance_2.internal_ip_address_vm
  }

}

resource "yandex_lb_network_load_balancer" "Net_balancer" {
  name = "sf-network-load-balancer"

  listener {
    name = "sf-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.lb_sf_vm.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "subnet_1" {
  name           = "subnet_1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet_2" {
  name           = "subnet_2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.11.0/24"]
}

module "instance_1" {
  source                = "./module/instance"
  instance_family_image = "lemp"
  subnet_mtfk           = yandex_vpc_subnet.subnet_1.id
  zone_name             = yandex_vpc_subnet.subnet_1.zone
}
module "instance_2" {
  source                = "./module/instance"
  instance_family_image = "lamp"
  subnet_mtfk           = yandex_vpc_subnet.subnet_2.id
  zone_name             = yandex_vpc_subnet.subnet_2.zone
}
