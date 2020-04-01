#!/bin/bash

ssh -o "StrictHostKeyChecking=no" \
    ubuntu@$(terraform output -state=terraform/terraform.tfstate east_consul_ip) \
    consul join -wan $(terraform output -state=terraform/terraform.tfstate west_consul_ip)

