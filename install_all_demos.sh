#!/bin/sh
echo "Installing Demos..."

## WAN Join
echo "---Calling WAN Join Demo---"
./wan_join.sh

# Consul k8s
echo "---Calling config Entries---"
export KUBECONFIG=$(pwd)/$(ls kubeconfig*west*)
./install_config_entries.sh
unset KUBECONFIG

# Consul k8s
echo "---Calling consul-k8s Demo---"
./install_consul_k8s.sh

# Modify CoreDNS
echo "---Modify kubesystem CoreDNS for Consul DNS Integration---"
./install_consul_dns.sh

# OpenFAAS
echo "---Calling OpenFaas Demo---"
./install_openfaas.sh

# k8s services Deployment
echo "---Calling k8s services Demo---"
./install_k8s_services.sh

# Ambassador Deployment
echo "---Calling Ambassador API Gateway Demo---"
./install_ambassador_demo.sh

# Metrics Pipeline
echo "---Calling Telemetry Metrics Demo---"
export KUBECONFIG=$(pwd)/$(ls kubeconfig*west*)
./install_telem_stack.sh
unset KUBECONFIG


# # Vault demo
# #TODO: WIP
# echo "---Calling Vault k8s Demo---"
# export KUBECONFIG=$(pwd)/$(ls kubeconfig*west*)
# cd ./k8s-transit-app
# ./full_stack_deploy.sh
# cd ..
# unset KUBECONFIG
# */

#How to Get Started
echo "command to access dashboard service:"
echo "KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) nohup kubectl port-forward dashboard 9002 &"
nohup kubectl port-forward dashboard 9002 &
echo "Open in browser: http://localhost:9002"

echo "command to access web service:"
echo "nohup kubectl port-forward service/web 9090 &"
nohup kubectl port-forward service/web 9090 &
echo "Open in browser: http://localhost:9090/ui/"
