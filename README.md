For Creating a AKS cluster with Automatic deployments:

## Requirements:
- A valid Azure subscription
- kubectl installed  
- azure-cli installed


## Steps:
1. Create a resource group, acr and aks:
```bash
az group create --name test-nginx --location uksouth

az acr create --resource-group test-nginx --name shrestharajat --sku Basic

az aks create --resource-group test-nginx --name nginx-cluster --node-count 1 --enable-addons monitoring
```

2. Link the ACR to AKS
```bash
az aks update -n nginx-cluster -g test-nginx --attach-acr shrestharajat
```

3. Push an initial image to ACR
```bash
az acr build --image nginx/testnginx:latest --registry shrestharajat --file Dockerfile .
```

4. Create and setup automatic deployment via azure portal
	- Go to cluster>automatic deployments>create cluster 
	- Select a github workflow name same as the deployment name
	- Select repo and branch
	- Go to Image settings after setting repo
	- Select Dockerfile
	- Select ACR and image repository image
	- Go to Deployment details
	- Select Kubernetes manifest
	- Select the deployment yml file
	- Select default namespace (Do not create a new one)
	- Review and create
	- After a while, a pull request will be created
	- Go to your github repo and accept the pull request
	[If you do not want to use the default namespace you will need to define a new service and ingress](https://learn.microsoft.com/en-us/training/modules/aks-deploy-container-app/7-exercise-expose-app)

5. TODO: fix the gha pulling image after deploy


## Msic commands:
```bash
# set context
az aks get-credentials --resource-group test-nginx --name nginx-cluster
kubectl config view

# Get the svc and pod details
kubectl get svc
kubectl get pods -o wide

# apply the deployments locally
kubectl apply -f ./nginx-test.yml
```