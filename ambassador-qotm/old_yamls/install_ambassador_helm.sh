#Cleanup old Install
kubectl delete -f ambassador-consul-connector.yaml
kubectl delete -f ambassador-service.yaml
kubectl delete -f ambassador-rbac.yaml
kubectl delete -f qotm.yaml
kubectl delete service ambassador -n ambassador
kubectl delete service ambassador-admin -n ambassador
kubectl delete service ambassador-redis -n ambassador
kubectl delete service ambassador -n ambassador
kubectl delete ratelimitservice ambassador-ratelimit
kubectl delete authservice ambassador-authservice
kubectl delete crd -l product=aes
kubectl delete crds --all
kubectl delete namespace ambassador
kubectl delete ClusterRoleBinding ambassador-crds
kubectl delete ClusterRoleBinding ambassador
kubectl delete ClusterRole ambassador-crds
kubectl delete ClusterRole ambassador

cat <<EOF > values.yaml
image:
  repository: quay.io/datawire/ambassador
  tag: 1.4.0
enableAES: true
EOF

kubectl apply -f https://www.getambassador.io/yaml/aes-crds.yaml
helm repo add datawire https://www.getambassador.io
helm repo update
kubectl create namespace ambassador
helm install ambassador --namespace ambassador datawire/ambassador
edgectl install

#For Ambassador Api only
#helm install ambassador datawire/ambassador --set image.repository=quay.io/datawire/ambassador --set image.tag=1.4.0 --set enableAES=false
#export SERVICE_IP=$(kubectl get svc --namespace default ambassador -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
#echo http://$SERVICE_IP:

