terraform {
  required_version = ">= 0.13"
  
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.100"
    }
  }

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-state-bucket"
    key        = "prod/terraform.tfstate"
    region     = "ru-central1"
    skip_region_validation      = true
    skip_credentials_validation = true
    encrypt    = true
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_zone
}

# Простой S3 бакет
resource "yandex_storage_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "private"
}
