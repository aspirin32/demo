terraform {
  required_version = "= v1.4.2"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.96.1"
    }
  }
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tfstate-diplom"
    region     = "ru-central1-a"
    key        = "diplom/diplom-state.tfstate"
    access_key = "YCAJEX_YaiooeBDMDUJ0oczBJ"
    secret_key = "YCPUUl8nnSxoFF80anhlZwfe8T1SnzC1ZEauMQys"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
provider "yandex" {
  token     = "y0_AgAAAAADrsOUAATuwQAAAADczEhqP8pEVx0lSC2xbJ6pG1AuFOTNODE"
  cloud_id  = "b1g77ra04er986sl1k1f"
  folder_id = "b1gcfconkmvhs7gilqm8"
}
resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "diplom"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.128.0.0/24"]
}
module "k8s-master" {
  module_name           = "k8s-master"
  source                = "./module/instance"
  instance_family_image = "ubuntu-2204-lts"
  subnet_mtfk           = yandex_vpc_subnet.subnet.id
  zone_name             = yandex_vpc_subnet.subnet.zone
}
module "k8s-worker" {
  module_name           = "k8s-worker"
  source                = "./module/instance"
  instance_family_image = "ubuntu-2204-lts"
  subnet_mtfk           = yandex_vpc_subnet.subnet.id
  zone_name             = yandex_vpc_subnet.subnet.zone
}
module "srv" {
  module_name           = "srv"
  source                = "./module/instance"
  instance_family_image = "ubuntu-2204-lts"
  subnet_mtfk           = yandex_vpc_subnet.subnet.id
  zone_name             = yandex_vpc_subnet.subnet.zone
}
module "ansible-master" {
  module_name           = "ansible-master"
  source                = "./module/instance"
  instance_family_image = "ubuntu-2204-lts"
  subnet_mtfk           = yandex_vpc_subnet.subnet.id
  zone_name             = yandex_vpc_subnet.subnet.zone
}