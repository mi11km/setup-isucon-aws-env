ssh-keygen -t rsa -f id_rsa_ec2

terraform init
terraform fmt
terraform validate
terraform apply -var "ami_id=$1"
