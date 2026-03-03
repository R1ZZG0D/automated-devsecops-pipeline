
# Automated DevSecOps PipeLine - devsecops-cd-pipeline

This is the CD pipeline.

## Prerequisites: Create 1 EC2 server

- Minikube server with 25 GB storage - t3.large



## Step 1: System Update

```shell
sudo apt update && sudo apt upgrade -y
```

## Step 2: Install Docker and add Ubuntu user to docker group

```shell
sudo apt install -y docker.io
sudo usermod -aG docker $USER
newgrp docker
docker ps
```

## Step 3: Install Required Dependencies

```shell
sudo apt install -y curl wget apt-transport-https conntrack
```

## Step 4: Install kubectl

```shell
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client
```

## Step 5: Install Latest Minikube

```shell
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64
sudo mv minikube-linux-amd64 /usr/local/bin/minikube
minikube version
```

## Step 6: Start Minikube

```shell
minikube start --driver=docker --memory=6000 --cpus=2
```

## Step 7: Verify Cluster

```shell
kubectl get nodes
```

You should see

```shell
minikube   Ready
```

## Step 8: Install ArgoCD

```shell
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.8.4/manifests/install.yaml
```

Wait for 1-2 minutes to let the pods start and then type:

```shell
kubectl get pods -n argocd
```

You should see all the pods Running. Make sure all pods are running as it is important.

## Step 9: Setup ArgoCD

Convert service to NodePort:

```shell
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
```

Check NodePort:

```shell
kubectl get svc argocd-server -n argocd
```

You’ll see something like:

```shell
80:31234/TCP
443:32001/TCP
```

Get ArgoCD Admin Password:

```shell
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Open Port 8080 in the Security Group by going to EC2 -> Security Group -> Add and then add the below rule:

- Type -> Custom TCP
- Port -> 8080
- Source -> 0.0.0.0/0

After this do Port Forwarding:

```shell
kubectl port-forward svc/argocd-server -n argocd 8080:443 --address 0.0.0.0
```

Now you can Access ArgoCD on https://<Your_EC2_Public_IP>:8080

Login using the default username: admin and the admin password you get using the above command. 

