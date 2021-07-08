ssh-keygen -t rsa -f id_rsa_ec2

terraform init
terraform fmt
terraform validate
if [ $# == 1 ]; then
  terraform apply -var "ami_id=$1"
else
  terraform apply -var "ami_id=ami-03bbe60df80bdccc0"
fi
