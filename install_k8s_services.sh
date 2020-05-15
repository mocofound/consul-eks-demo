#!/bin/sh
echo "Installing k8s services in West"
KUBECONFIG=$(pwd)/$(ls kubeconfig*east*) kubectl apply -f ./app
KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) kubectl apply -f ./app