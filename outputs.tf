output "bucket_name" {
  value       = yandex_storage_bucket.bucket.bucket
  description = "Name of the created S3 bucket"
}

output "bucket_url" {
  value       = "https://storage.yandexcloud.net/${yandex_storage_bucket.bucket.bucket}"
  description = "URL of the S3 bucket"
} 