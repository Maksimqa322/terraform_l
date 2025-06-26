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