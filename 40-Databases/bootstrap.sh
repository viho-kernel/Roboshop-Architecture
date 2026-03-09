#!/bin/bash

component=$1
environment=$2
dnf install ansible -y

cd /home/ec2-user
git clone https://github.com/viho-kernel/Ansible-Roles-Roboshop.git
cd Ansible-Roles-Roboshop
git pull
ansible-playbook -e component=$component -e env=$environment  main.yaml