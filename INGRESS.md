## AKS Ingress demo

## Steps:
1. Create two deployment yml files for the demo applications (Done in this repo)

2. Switch to the hello-world namespace and apply the deployments
```bash
kubectl create namespace hello-world
kubectl config set-context --current --namespace=hello-world
kubectl create -f hw1.yml
kubectl create -f hw2.yml
```

3. Install the nginx-ingress on a seprate namespace using helm
```bash
# create a new namespace, and use helm to install ingress
NAMESPACE=ingress-basic

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \ --create-namespace \ --namespace $NAMESPACE \ --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz
```
4. Use hello world ingress yml file to deploy the ingress services

```
kubectl create -f hello-world-ingress.yml
```

### Debugging commands:
```bash
# To view the running pods:
kubectl get po
kubectl get po --all-namespaces

# To view services:
kubectl get svc
kubectl get svc --all-namespaces

## To view ingress:
kubectl get ingress
kubectl get ingress --all-namespaces

## To view all of these at the same time
kubectl get ingress,po,svc
kubectl get ingress,po,svc --all-namespaces

## To view the current config on kubectl
kubectl view config

## To delete config contexts, users, and clusters
kubectl config unset clusters
kubectl config unset contexts
kubectl config unset users

```
