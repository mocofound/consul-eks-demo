#!/bin/bash

cluster_name=$1
k8s_host=$(aws eks describe-cluster --name $cluster_name | jq -r .cluster.endpoint)
k8s_ca=$(kubectl config view --raw -o json | jq -r '.clusters[0].cluster."certificate-authority-data"' | tr -d '"' | base64 --decode)
k8s_sa=$(kubectl get sa hashicorp-consul-connect-injector-authmethod-svc-account -o json | jq -r ".secrets[0].name")
k8s_jwt=$(kubectl get secrets $k8s_sa -o json | jq -r .data.token | gbase64 -d)

# WIP debug info
echo $cluster_name
echo $k8s_host
echo $k8s_ca
echo $k8s_sa
echo $k8s_jwt


acl_token=$(echo -n $CONSUL_HTTP_TOKEN | gbase64 -w 0) 
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: hashicorp-consul-client-acl-token
type: Opaque
data:
  token: $acl_token
EOF


cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: hashicorp-consul-connect-inject-acl-token
type: Opaque
data:
  token: $acl_token
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: hashicorp-consul-catalog-sync-acl-token
type: Opaque
data:
  token: $acl_token
EOF

consul acl auth-method create -type "kubernetes" \
    -name "hashicorp-consul-k8s-auth-method" \
    -description "k8s auth" \
    -kubernetes-host "${k8s_host}" \
    -kubernetes-ca-cert "${k8s_ca}" \
    -kubernetes-service-account-jwt "${k8s_jwt}"
consul acl binding-rule create -method 'hashicorp-consul-k8s-auth-method' \
    -description 'apps' \
    -bind-type 'service' \
    -bind-name '${serviceaccount.name}' \
    -selector 'serviceaccount.namespace==default'
