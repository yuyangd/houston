#!/usr/bin/env bash

# This bootstrap script is used in aws user data to
# 1. Run ansible to provision the server
# 2. Deploy the app to target location
# 3. Start service

set -ouex pipefail

# su -c '/home/ec2-user/houston/scripts/bootstrap.sh' - ec2-user
sudo pip install ansible==2.4.0.0

if [ ! -d '/etc/ansible' ]; then
  sudo mkdir /etc/ansible
fi

sudo cp /home/ec2-user/houston/ansible/hosts /etc/ansible/hosts

/usr/local/bin/ansible-playbook /home/ec2-user/houston/ansible/playbook-aws.yml
