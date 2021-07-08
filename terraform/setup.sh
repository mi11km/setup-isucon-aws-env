#!/bin/zsh

webhook_url=https://discord.com/api/webhooks/862698740049903616/3OGleL7xA6k1FVszTmVd9wS4GDx_1SfRDQXqGSR0kGKp3AdhwnKg0T8ubccbyM_qDtky
ssh_key_name=id_rsa_ec2

ssh-keygen -t rsa -f ${ssh_key_name}

terraform init
terraform fmt
terraform validate

if [ $# != 1 ]; then
  terraform apply -var "ami_id=ami-03bbe60df80bdccc0"
else
  terraform apply -var "ami_id=$1"
fi

# send ssh secret key to discord channel
curl -F 'payload_json={"content": "洩らしちゃだめよ"}' \
  -F "file1=@${ssh_key_name}" \
  ${webhook_url}
