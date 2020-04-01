#!/bin/sh
echo "Installing Consul k8s in east EKS cluster"
KUBECONFIG=$(pwd)/$(ls kubeconfig*east*) helm install consul -f $(ls *east*values.yaml) ./consul-helm
echo "Installing Consul k8s in west EKS cluster"
KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) helm install consul -f $(ls *west*values.yaml) ./consul-helm