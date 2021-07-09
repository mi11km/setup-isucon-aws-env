#!/bin/bash

webhook_url=https://discord.com/api/webhooks/862698740049903616/3OGleL7xA6k1FVszTmVd9wS4GDx_1SfRDQXqGSR0kGKp3AdhwnKg0T8ubccbyM_qDtky
ssh_key_name=id_rsa_ec2

send_ip() {
  ip=($(terraform apply -auto-approve -var "ami_id=$1" | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | tail -3 | tr '\n' ' '))
  for i in ${ip[@]} ; do
    curl -X POST \
    -H "Content-Type: application/json" \
    -d '{"username": "ip addressだよー", "content": "ssh -i id_rsa_ec2 ubuntu@'$i'"}' \
    ${webhook_url}
  done
}


ssh-keygen -t rsa -f ${ssh_key_name}

terraform init
terraform fmt
terraform validate

if [ $# -ne 1 ]; then
  send_ip ami-03bbe60df80bdccc0
else
  send_ip $1
fi

# send ssh secret key to discord channel
curl -F 'payload_json={"content": "洩らしちゃだめよ"}' \
  -F "file1=@${ssh_key_name}" \
  ${webhook_url}

