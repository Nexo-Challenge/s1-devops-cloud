#!/usr/bin/env bash
# Executar no Azure Cloud Shell (Bash) após selecionar a assinatura.
set -euo pipefail
: "${AZURE_SUBSCRIPTION_ID:?Informe a assinatura escolhida}"
NEXO_RG=${NEXO_RG:-rg-nexo-sprint1}
NEXO_LOCATION=${NEXO_LOCATION:-eastus}
NEXO_VM_SIZE=${NEXO_VM_SIZE:-Standard_D2s_v4}
NEXO_VM=vm-nexo-sprint1
az account set --subscription "$AZURE_SUBSCRIPTION_ID"
if [[ $(az group exists --name "$NEXO_RG") == true ]]; then
  echo "O grupo $NEXO_RG já existe. Confira-o antes de prosseguir; nada foi substituído." >&2; exit 1
fi
az group create --name "$NEXO_RG" --location "$NEXO_LOCATION" \
  --tags project=NEXO purpose=sprint1-devops managed-by=nexo-devops --output table
az network nsg create --resource-group "$NEXO_RG" --name nsg-nexo --output none
# Sem regras de entrada: comandos e testes serão executados pelo agente Azure.
az vm create --resource-group "$NEXO_RG" --name "$NEXO_VM" \
  --location "$NEXO_LOCATION" --image Ubuntu2204 --size "$NEXO_VM_SIZE" \
  --admin-username azureuser --generate-ssh-keys --nsg nsg-nexo --nsg-rule NONE \
  --public-ip-sku Standard --storage-sku Standard_LRS --os-disk-size-gb 30 \
  --tags project=NEXO purpose=sprint1-devops --output table
az vm show --resource-group "$NEXO_RG" --name "$NEXO_VM" --show-details \
  --query '{name:name,powerState:powerState,publicIp:publicIps,location:location}' --output table
echo 'VM provisionada. Próximo passo: azure/deploy.sh a partir deste pacote.'
