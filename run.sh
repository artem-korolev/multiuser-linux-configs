#!/bin/bash

command -v ansible-playbook >/dev/null 2>&1 || sudo -H pip install ansible
ansible-playbook playbook.yml

