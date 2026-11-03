#!/usr/bin/env bash
set -euo pipefail
: "${AZURE_SUBSCRIPTION_ID:?Informe a assinatura escolhida}"
NEXO_RG=${NEXO_RG:-rg-nexo-sprint1}
az account set --subscription "$AZURE_SUBSCRIPTION_ID"
az vm show -g "$NEXO_RG" -n vm-nexo-sprint1 -d \
  --query '{name:name,powerState:powerState,location:location}' -o table
RESULT=$(az vm run-command invoke -g "$NEXO_RG" -n vm-nexo-sprint1 --command-id RunShellScript \
  --scripts 'set -eu; cd /opt/nexo-devops; docker ps --filter name=nexo-api; bash scripts/verify.sh; curl -fsS http://127.0.0.1:8080/api/aplicacoes; echo NEXO_VERIFY_OK' \
  --query 'value[].message' -o tsv)
printf '%s\n' "$RESULT"
[[ "$RESULT" == *NEXO_VERIFY_OK* ]] || { echo 'Verificação remota não confirmou sucesso.' >&2; exit 1; }
