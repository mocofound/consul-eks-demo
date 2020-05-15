#!/bin/sh
echo "Installing Consul k8s in east EKS cluster"
KUBECONFIG=$(pwd)/$(ls kubeconfig*east*) helm install consul -f $(ls *east*values.yaml) ./consul-helm
echo "Installing Consul k8s in west EKS cluster"
KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) helm install consul -f $(ls *west*values.yaml) ./consul-helm

sleep 10s

# #TODO WIP
# echo "Adding Stub DNS for .consul TLD in East EKS Cluster"
# export KUBECONFIG=$(pwd)/$(ls kubeconfig*east*) cat <<EOF | kubectl apply -f -
# apiVersion: v1
# kind: ConfigMap
# metadata:
#   labels:
#     addonmanager.kubernetes.io/mode: EnsureExists
#   name: kube-dns
#   namespace: kube-system
# data:
#   stubDomains: |
#     {"consul": ["$(kubectl get svc consul-consul-dns -o jsonpath='{.spec.clusterIP}')"]}
# EOF

# echo "Adding Stub DNS for .consul TLD in West EKS Cluster"
# export KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) cat <<EOF | kubectl apply -f -
# apiVersion: v1
# kind: ConfigMap
# metadata:
#   labels:
#     addonmanager.kubernetes.io/mode: EnsureExists
#   name: kube-dns
#   namespace: kube-system
# data:
#   stubDomains: |
#     {"consul": ["$(kubectl get svc consul-consul-dns -o jsonpath='{.spec.clusterIP}')"]}
# EOF

unset KUBECONFIG