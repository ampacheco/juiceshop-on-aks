az group create --name 000_JS-AKS-RG --location eastus
az aks create -n JS-AKS -g 000_JS-AKS-RG --network-plugin azure --enable-managed-identity -a ingress-appgw --appgw-name myApplicationGateway --appgw-subnet-cidr "10.225.0.0/16" --generate-ssh-keys --node-count 1
appGatewayId=$(az aks show -n 000_JS-AKS-RG -g myResourceGroup -o tsv --query "addonProfiles.ingressApplicationGateway.config.effectiveApplicationGatewayId")
appGatewayId=$(az aks show -n JS-AKS -g 000_JS-AKS-RG -o tsv --query "addonProfiles.ingressApplicationGateway.config.effectiveApplicationGatewayId")
agicAddonIdentity=$(az aks show -n JS_AKS -g 000_JS-AKS-RG -o tsv --query "addonProfiles.ingressApplicationGateway.identity.clientId")
agicAddonIdentity=$(az aks show -n JS-AKS -g 000_JS-AKS-RG -o tsv --query "addonProfiles.ingressApplicationGateway.identity.clientId")
az aks get-credentials -n JS-AKS -g 000_JS-AKS-RG