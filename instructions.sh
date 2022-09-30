#!/bin/sh

# you will need a basic azure subscription to do this operation 

# Create a container registry and resource group
#create a basic resource group
az group create --name test-nginx --location uksouth 

# create a new container registry with a uniquename
az acr create --resource-group test-nginx --name shrestharajat --sku Basic

# link the acr to aks
az aks update -n testnginxakscluster -g test-nginx-42069 --attach-acr shrestharajat


# note if 

#create a image and push it to ecr
az acr build --image nginx/testnginx:v1 --registry shrestharajat --file Dockerfile .