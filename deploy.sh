resource_group_name=000_JS-AKS-RG
cluster_name=JS-AKS

az group create --name ${resource_group_name} --location eastus
az aks create -n ${cluster_name} -g ${resource_group_name} --network-plugin azure --enable-managed-identity -a ingress-appgw --appgw-name myApplicationGateway --appgw-subnet-cidr "10.225.0.0/16" --generate-ssh-keys --node-count 1

# Get application gateway id from AKS addon profile
appGatewayId=$(az aks show -n ${cluster_name} -g ${resource_group_name} -o tsv --query "addonProfiles.ingressApplicationGateway.config.effectiveApplicationGatewayId")

# Get Application Gateway subnet id
appGatewaySubnetId=$(az network application-gateway show --ids $appGatewayId -o tsv --query "gatewayIPConfigurations[0].subnet.id")

# Get AGIC addon identity
agicAddonIdentity=$(az aks show -n ${cluster_name} -g ${resource_group_name} -o tsv --query "addonProfiles.ingressApplicationGateway.identity.clientId")

# Assign network contributor role to AGIC addon identity to subnet that contains the Application Gateway
az role assignment create --assignee $agicAddonIdentity --scope $appGatewaySubnetId --role "Network Contributor"

az aks get-credentials -n ${cluster_name} -g ${resource_group_name}