#!/bin/bash
# This script is meant to be invoked in a cronjob to continously run our infra playbooks
cd /home/centos/network-infra
git checkout master -q
git pull -q
cd /home/centos/network-infra-playbooks
git checkout master -q
git pull -q
flock -n /tmp/ansible-playbook.lock ansible-playbook --vault-password-file .vaultpass -i inventories/$(cat .ci_environment)/hosts site.yml
