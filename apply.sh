#!/bin/bash
set -a
source .env
set -a

while true; do
	read -p "Running this script will create a chargeable HCloud vServer with $FSMS_INSTANCES instance(s) of FSMS running on it. Continue? (y/n) " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

rm -f hosts
cd terraform/

terraform apply \
	-var="hcloud_token=$HCLOUD_TOKEN" \
	-var="hcloud_datacenter=$HCLOUD_DATACENTER" \
	-var="ssh_keys_to_inject=$SSH_KEYS_TO_INJECT" \
	-var="fsms_instances=$FSMS_INSTANCES"

