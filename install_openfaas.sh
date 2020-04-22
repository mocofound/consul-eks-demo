#!/bin/sh
echo "Installing OpenFaaS in east EKS cluster"
KUBECONFIG=$(pwd)/$(ls kubeconfig*east*) k3sup app install openfaas --load-balancer
echo "Installing OpenFaaS in west EKS cluster"
KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) k3sup app install openfaas --load-balancer


echo "Installing OpenFaaS in east EKS cluster"
KUBECONFIG=$(pwd)/$(ls kubeconfig*east*) arkade install openfaas --load-balancer
echo "Installing OpenFaaS in west EKS cluster"
KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) arkade install openfaas --load-balancer

