  108  az group create --name 000_JS-AKS-RG --location eastus
  109  az aks create -n JS-AKS -g 000_JS-AKS-RG --network-plugin azure --enable-managed-identity -a ingress-appgw --appgw-name myApplicationGateway --appgw-subnet-cidr "10.225.0.0/16" --generate-ssh-keys --node-count 1
  110  appGatewayId=$(az aks show -n 000_JS-AKS-RG -g myResourceGroup -o tsv --query "addonProfiles.ingressApplicationGateway.config.effectiveApplicationGatewayId")
  111  appGatewayId=$(az aks show -n JS-AKS -g 000_JS-AKS-RG -o tsv --query "addonProfiles.ingressApplicationGateway.config.effectiveApplicationGatewayId")
  115  agicAddonIdentity=$(az aks show -n JS_AKS -g 000_JS-AKS-RG -o tsv --query "addonProfiles.ingressApplicationGateway.identity.clientId")
  116  agicAddonIdentity=$(az aks show -n JS-AKS -g 000_JS-AKS-RG -o tsv --query "addonProfiles.ingressApplicationGateway.identity.clientId")
  125  az aks get-credentials -n JS-AKS -g 000_JS-AKS-RG
