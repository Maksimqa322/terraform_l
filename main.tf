terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_zone
}

resource "yandex_compute_instance" "default" {
  name        = "terraform-instance"
  platform_id = "standard-v1"

  resources {
    core_fraction = 5
    cores         = 2
    memory        = 1
  }

  boot_disk {
    initialize_params {
      image_id = "fd8l7di2ic805du7tav5"
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
}
