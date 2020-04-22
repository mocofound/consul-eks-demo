#Edit k8s DNS.  
#https://www.consul.io/docs/platform/k8s/dns.html

#Get IP of Consul DNS Service172.20.171.197
kubectl get svc consul-consul-dns -o jsonpath='{.spec.clusterIP}'

#Modify configmap for coredns 
kubectl edit configmap coredns -n kube-system

#test with tiny-tools.yaml from https://www.consul.io/docs/platform/k8s/dns.html
kubectl apply -f tiny-tools.yaml

#Find Tiny Tools Pod
kubectl get pods -A | grep tiny

#Get Logs
kubectl logs <podname from tiny grep> tiny-tools
