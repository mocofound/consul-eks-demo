echo "UnInstalling Web App in east EKS cluster"
KUBECONFIG=$(pwd)/$(ls kubeconfig*east*) kubectl delete -f ./app
echo "UnInstalling Web App in west EKS cluster"
KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) kubectl delete -f ./app

echo "UnInstalling Ambassador in east EKS cluster"
KUBECONFIG=$(pwd)/$(ls kubeconfig*east*) kubectl delete -f ./ambassador-qotm
echo "UnInstalling Ambassador in west EKS cluster"
KUBECONFIG=$(pwd)/$(ls kubeconfig*west*) kubectl delete -f ./ambassador-qotm