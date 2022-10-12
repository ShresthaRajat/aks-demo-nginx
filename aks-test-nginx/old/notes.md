```bash
// create a resource group
az group create --name test-nginx --location uksouth

// create a container registry
az acr create --resource-group test-nginx \
  --name testNginx --sku Basic

az acr build --image testnginx \
  --registry testNginx \
  --file dockerfile .

#
az group create --name test-nginx --location uksouth
az aks create --resource-group test-nginx --name nginx-cluster --node-count 2 --enable-addons monitoring --generate-ssh-keys

```