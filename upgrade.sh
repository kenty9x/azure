az account set --subscription <id>
az aks get-credentials --resource-group <resource-name> --name <aks-name>

subName="Subscription-Name"
RG=$(az group list --subscription ${subName} --query "[?ends_with(name,'-rg')].{name:name}" -o tsv)
AKS=$(az aks list -g ${RG} --subscription ${subName} --query "[].{name:name}" -o tsv)

az aks get-upgrades --name ${AKS} -g ${RG}

for n in $(kubectl get nodes --no-headers | awk '{print $1}'); do kubectl cordon $n; done

az aks upgrade --kubernetes-version <current-version> --name ${AKS} -g ${RG}

az aks nodepool update --cluster-name ${AKS} --resource-group ${RG} --name --subscription ${subName} --mode System
az aks upgrade --node-image-only --name ${AKS} -g ${RG} --kubernetes-version <new-version>


az aks get-upgrades -n <aks-name> --resource-group <resource-group-name>
