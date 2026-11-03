#!/usr/bin/env bash
set -euo pipefail
: "${AZURE_SUBSCRIPTION_ID:?Informe a assinatura escolhida}"
NEXO_RG=${NEXO_RG:-rg-nexo-sprint1}
NEXO_SHUTDOWN_UTC=${NEXO_SHUTDOWN_UTC:-$(date -u -d '+2 hours' +%H%M)}
az account set --subscription "$AZURE_SUBSCRIPTION_ID"
az vm auto-shutdown --resource-group "$NEXO_RG" --name vm-nexo-sprint1 \
  --time "$NEXO_SHUTDOWN_UTC" --output json
echo "Desligamento automático diário configurado para $NEXO_SHUTDOWN_UTC UTC."
echo 'Disco e IP permanecem alocados até a exclusão do grupo.'
