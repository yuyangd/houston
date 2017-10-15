#!/usr/bin/env bash
set -ouex pipefail

# su -c '/home/ec2-user/houston/scripts/bootstrap.sh' - ec2-user

cd /home/ec2-user

git clone https://github.com/duy156/houston.git

sudo pip install ansible==2.4.0.0

mkdir /etc/ansible

cp /home/ec2-user/houston/ansible/hosts /etc/ansible/hosts

/usr/local/bin/ansible-playbook /home/ec2-user/houston/ansible/playbook-aws.yml

cp /home/ec2-user/houston/simple-sinatra-app/* /opt/sinatra

/home/ec2-user/.gem/ruby/2.4.0/bin/unicorn -c /opt/unicorn.rb -D
