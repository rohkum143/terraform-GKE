terraform plan -var-file="staging.tfvars" -out=staging.out
terraform apply "staging.out"
