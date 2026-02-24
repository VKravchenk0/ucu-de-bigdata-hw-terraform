1. Сконфігурувати gsutil
2. Заповнити значеннz d terraform.tfvars
3. Створити бакет для збереження terraform-стейту. Вказати його в provider.tf
```bash
gsutil mb \
  -p playground-482811 \
  -l us-central1 \
  gs://playground-482811-terraform-state

gsutil versioning set on gs://playground-482811-terraform-state
```
4. Запустити terraform
```bash
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```
5. Видалення ресурсів
```bash
terraform destroy

gsutil rm -r gs://playground-482811-terraform-state
```