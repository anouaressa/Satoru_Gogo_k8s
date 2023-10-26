#/bin/bash

#Check if k3s is running
echo "--------------------Check if k3s is running--------------------"
if [ "$(systemctl is-active k3s.service)" = "active" ]; then
    echo "k3s is running"
else
    echo "k3s is not running"
    echo "Starting k3s"
    sudo systemctl start k3s.service
fi

#Create Namespace
echo "--------------------Create Argocd Namespace--------------------"
kubectl create ns argocd || true

#Deploy Argocd
echo "--------------------Deploy Argocd--------------------"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

#Sleep 1 miniute
echo "--------------------Waiting 1m for the pods to start--------------------"
sleep 1m

#Change to Nodeport
echo "--------------------Change Argocd Service to NodePort--------------------"
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'

#Get Nodeport
echo "--------------------Get Argocd NodePort--------------------"
kubectl get svc -n argocd argocd-server -o yaml | grep nodePort

#ArgoCD Pass
echo "--------------------ArgoCD UI Password--------------------"
echo "Username: admin"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > argo-pass.txt