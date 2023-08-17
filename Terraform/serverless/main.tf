terraform {
  required_version = "= v1.4.2"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.86.0"
    }
  }
}
provider "yandex" {
  token     = "-"
  cloud_id  = "-"
  folder_id = "-"
}
resource "yandex_function" "test-function" {
    name               = "test-function"
    description        = "Test function"
    user_hash          = "first-function"
    runtime            = "python37"
    entrypoint         = "main"
    memory             = "128"
    execution_timeout  = "10"
    service_account_id = "ajes9hrs27usjjc3irhq"
    tags               = ["testing"]
    content {
        zip_filename = "./main.zip"
    }
}