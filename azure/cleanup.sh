#!/usr/bin/env bash
# Executar SOMENTE depois de gravar o vídeo e guardar as evidências.
set -euo pipefail
: "${AZURE_SUBSCRIPTION_ID:?Informe a assinatura escolhida}"
NEXO_RG=${NEXO_RG:-rg-nexo-sprint1}
az account set --subscription "$AZURE_SUBSCRIPTION_ID"
[[ $(az group show -n "$NEXO_RG" --query 'tags.project' -o tsv) == NEXO ]]
[[ $(az group show -n "$NEXO_RG" --query 'tags.purpose' -o tsv) == sprint1-devops ]]
az resource list -g "$NEXO_RG" --query '[].{name:name,type:type}' -o table
read -r -p "Exclusão definitiva dos recursos acima. Digite $NEXO_RG para confirmar: " CONFIRM_GROUP
[[ "$CONFIRM_GROUP" == "$NEXO_RG" ]] || { echo 'Cancelado.'; exit 1; }
az group delete --name "$NEXO_RG" --yes
[[ $(az group exists --name "$NEXO_RG") == false ]]
echo 'Grupo excluído: confirmação az group exists = false'
