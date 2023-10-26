# Satoru_Gogo_k8s
This repo containe manifest files to deploy a simple app into k8s cluster

** Step 1 **
Install Required Tools

´´´
sudo apt install -y curl wget
´´´

Install K3s Kubernetes Cluster

´´´
curl -sfL https://get.k3s.io | sh - 
´´´´

cheking the status of k3s service

´´´
sudo systemctl status k3s
´´´

**step 2: Configure Kubectl **
To interact with the K3s Kubernetes cluster, you need to configure the kubectl command-line tool to communicate with the K3s API server. The K3s installation script install kubectl binary automatically for you.


#install kubectl

´´´
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
´´´

´´´
chmod +x kubectl
´´´

´´´
sudo mv kubectl /usr/local/bin/
´´´

´´´kubectl version --client ´´´´


´´´
mkdir ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config && sudo chown $USER ~/.kube/config
sudo chmod 600 ~/.kube/config && export KUBECONFIG=~/.kube/config
´´´
** let's deploy our first application **






