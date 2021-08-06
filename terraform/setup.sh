#!/bin/bash

webhook_url=https://discord.com/api/webhooks/862698740049903616/3OGleL7xA6k1FVszTmVd9wS4GDx_1SfRDQXqGSR0kGKp3AdhwnKg0T8ubccbyM_qDtky
ssh_key_name=id_rsa_ec2
number_of_server=4
username=ubuntu

send_ip() {
  ip=($(terraform apply -auto-approve -var "ami_id=$1" | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | tail -${number_of_server} | tr '\n' ' '))

  # send ssh connect command to discord channel
  # shellcheck disable=SC2068
  for i in ${ip[@]}; do
      curl -X POST \
        -H "Content-Type: application/json" \
        -d '{"username": "ip addressだよー", "content": "ssh -i '${ssh_key_name}' '${username}'@'$i'"}' \
        ${webhook_url}
    echo "ssh -i $ssh_key_name $username@$i"
  done
  echo "sudo -i -u isucon"
}

ssh-keygen -t rsa -f $ssh_key_name

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
