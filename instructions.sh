#!/bin/sh

# you will need a basic azure subscription to do this operation 

# Create a resource group, acr and aks
az group create --name test-nginx --location uksouth 
az acr create --resource-group test-nginx --name shrestharajat --sku Basic
az aks create --resource-group test-nginx --name nginx-cluster --node-count 1 --enable-addons monitoring

# link the acr to aks
az aks update -n nginx-cluster -g test-nginx --attach-acr shrestharajat

# push an image to acr
az acr build --image nginx/testnginx:latest --registry shrestharajat --file Dockerfile .

# Create and setup automatic deployment via azure portal
# -> Go to cluster>automatic deployments>create cluster
# -> Select a github workflow name same as the deployment name
# -> Select repo and branch
# -> Go to Image settings after setting repo 
# -> Select Dockerfile
# -> Select ACR and image repository image
# -> Go to Deployment details
# -> Select Kubernetes manifest
# -> Select the deployment yml file
# -> Select default namespace (Do not create a new one)
# -> Review and create
# -> After a while, a pull request will be created 
# -> Go to your github repo and accept the pull request

# Msic commands:
# set context
az aks get-credentials --resource-group test-nginx --name nginx-cluster
kubectl config view

# Get the svc and pod details
kubectl get svc
kubectl get pods -o wide
# kubectl apply -f ./nginx-test.yml
