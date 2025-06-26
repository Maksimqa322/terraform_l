# terraform_l

Этот проект использует Terraform для создания виртуальной машины (VM) в Яндекс.Облаке (Yandex Cloud).

## Состав
- Создаёт одну виртуальную машину с помощью ресурса `yandex_compute_instance`.
- Использует переменные для параметризации облака, папки, зоны, токена и подсети.

## Требования
- [Terraform](https://www.terraform.io/) >= 0.13
- Аккаунт в [Yandex Cloud](https://cloud.yandex.ru/)
- Созданные Cloud ID, Folder ID, Subnet ID
- OAuth-токен Yandex Cloud

## Переменные

| Имя           | Описание                        | Тип    | Обязательная | Значение по умолчанию |
|---------------|----------------------------------|--------|--------------|----------------------|
| yc_token      | Yandex Cloud OAuth token         | string | да           | -                    |
| yc_cloud_id   | Yandex Cloud ID                  | string | да           | -                    |
| yc_folder_id  | Yandex Cloud Folder ID           | string | да           | -                    |
| yc_zone       | Yandex Cloud default zone        | string | нет          | ru-central1-a        |
| subnet_id     | Subnet ID для VM                 | string | да           | -                    |

## Быстрый старт

1. Клонируйте репозиторий и перейдите в папку проекта:
   ```sh
   git clone <repo_url>
   cd terraform_l
   ```
2. Создайте файл `terraform.tfvars` и укажите значения переменных:
   ```hcl
   yc_token    = "<ваш_yc_token>"
   yc_cloud_id = "<ваш_cloud_id>"
   yc_folder_id = "<ваш_folder_id>"
   subnet_id   = "<ваш_subnet_id>"
   # yc_zone можно не указывать, если подходит ru-central1-a
   ```
3. Инициализируйте Terraform:
   ```sh
   terraform init
   ```
4. Проверьте план развертывания:
   ```sh
   terraform plan
   ```
5. Примените изменения:
   ```sh
   terraform apply
   ```

## Структура файлов
- `main.tf` — основной файл инфраструктуры
- `variables.tf` — описание переменных
- `README.md` — этот файл

## Примечания
- Значение `core_fraction` в ресурсе VM выставлено в 5 — это минимальная доля CPU, проверьте, поддерживается ли она в вашем регионе/квоте.
- Для доступа к VM по публичному IP используется NAT.
- Для удаления ресурсов выполните:
  ```sh
  terraform destroy
  ```

---

## Управление Terraform State

Terraform использует state-файл (`terraform.tfstate`) для хранения текущего состояния инфраструктуры. Этот файл критически важен, так как:
- Содержит все созданные ресурсы и их параметры.
- Используется для сравнения желаемого и текущего состояния при каждом запуске `plan` и `apply`.

### Почему важно правильно управлять state-файлом?

- **Безопасность:** В state-файле могут храниться чувствительные данные (например, пароли, токены, IP-адреса) в открытом виде.
- **Согласованность:** Если несколько человек работают с инфраструктурой, локальный state-файл может привести к конфликтам и потере данных.
- **Восстановление:** Потеря state-файла = потеря контроля над инфраструктурой.

### Рекомендации по хранению state

- **Локальный state** подходит только для экспериментов и обучения. Для командной работы и продакшена используйте remote backend.
- **Remote backend** — это хранение state-файла в облаке с поддержкой блокировок и версионирования:
  - AWS: S3 + DynamoDB (для блокировок)
  - Azure: Azure Storage Account
  - GCP: Google Cloud Storage
  - Terraform Cloud/Enterprise

#### Пример backend для AWS S3 + DynamoDB

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "my-terraform-locks"
    encrypt        = true
  }
}
```

- **Блокировки (Locking):** Необходимы для предотвращения одновременного изменения state несколькими пользователями. В AWS для этого используется DynamoDB.

### Чувствительность данных

- State-файл может содержать секреты в открытом виде.
- Используйте атрибут `sensitive = true` для переменных и output, чтобы скрывать их в выводе Terraform.
- Для хранения секретов используйте внешние секрет-менеджеры (например, AWS Secrets Manager, HashiCorp Vault).