#!/bin/bash

component = $1
environment = $2

sudo dnf instsall ansible -y

git clone https://github.com/viho-kernel/Ansible-Roles-Roboshop.git

cd Ansible-Roles-Roboshop

git pull

ansible-playbook -e component=$component env=$environment main.yaml

