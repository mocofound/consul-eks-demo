echo "Installing Ambassador in east EKS cluster"
#KUBECONFIG=$(pwd)/$(ls kubeconfig*east*) kubectl apply -f ./ambassador-qotm

echo "Installing Ambassador in west EKS cluster"
KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) kubectl apply -f ./ambassador-qotm
KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) edgectl install
#KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) kubectl create namespace ambassador
#KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) kubectl apply -f ./ambassador-qotm/aes-crds.yaml && \
#KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) kubectl wait --for condition=established --timeout=90s crd -lproduct=aes && \
#KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) kubectl apply -f ./ambassador-qotm/aes-crds.yaml && \
#KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) kubectl -n ambassador wait --for condition=available --timeout=90s deploy -lproduct=aes
#KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) kubectl get -n ambassador service ambassador -o "go-template={{range .status.loadBalancer.ingress}}{{or .ip .hostname}}{{end}}"
