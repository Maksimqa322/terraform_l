terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  zone      = "ru-central1-a"
  token     = "REPLACED_SECRET"
  cloud_id  = "b1g4cpsvgtbt8dej02g0"
  folder_id = "b1gehd65o0g9dr81jndo"
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
      image_id = "fl8o5ot86e2sucpdrg4g"
    }
  }
  network_interface {
    subnet_id = "e9bdgo95ucmut6r7pioq"
    nat       = true
  }
}
