#!/usr/bin/env bash
# Executar no Cloud Shell, a partir do pacote local. Não requer publicar no GitHub.
set -euo pipefail
: "${AZURE_SUBSCRIPTION_ID:?Informe a assinatura escolhida}"
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
NEXO_RG=${NEXO_RG:-rg-nexo-sprint1}
az account set --subscription "$AZURE_SUBSCRIPTION_ID"
WORK=$(mktemp -d)
trap 'rm -rf -- "$WORK"' EXIT
tar --exclude=__pycache__ -czf "$WORK/app.tar.gz" -C "$ROOT" \
  docker/Dockerfile docker/.dockerignore docker/config scripts azure/install-docker.sh
PAYLOAD=$(base64 -w 0 "$WORK/app.tar.gz")
DIGEST=$(sha256sum "$WORK/app.tar.gz" | cut -d ' ' -f 1)
{
  printf '%s\n' '#!/bin/sh' "exec /bin/bash <<'NEXO_REMOTE_BASH'"
  printf '%s\n' 'set -eu' 'apt-get update' 'apt-get install -y git ca-certificates curl sudo python3'
  printf '%s\n' "test ! -e /opt/nexo-devops || { echo 'Diretório já existe; verificar implantação anterior.'; exit 1; }"
  printf '%s\n' 'mkdir -p /opt/nexo-devops'
  printf "printf '%%s' '%s' | base64 -d > /tmp/nexo-app.tar.gz\n" "$PAYLOAD"
  printf "echo '%s  /tmp/nexo-app.tar.gz' | sha256sum -c -\n" "$DIGEST"
  printf '%s\n' 'tar -xzf /tmp/nexo-app.tar.gz -C /opt/nexo-devops' 'rm /tmp/nexo-app.tar.gz'
  printf '\n%s\n' 'cd /opt/nexo-devops' 'bash azure/install-docker.sh' 'bash scripts/build-image.sh' \
    'bash scripts/run-container.sh demo' 'bash scripts/verify.sh' 'python3 scripts/smoke-crud.py' \
    'docker ps --filter name=nexo-api' \
    "docker image inspect nexo-api:sprint1 --format '{{.Id}}'" 'echo NEXO_DEPLOY_OK' 'NEXO_REMOTE_BASH'
} > "$WORK/remote.sh"
RESULT=$(az vm run-command invoke --resource-group "$NEXO_RG" --name vm-nexo-sprint1 \
  --command-id RunShellScript --scripts @"$WORK/remote.sh" --query 'value[].message' --output tsv)
printf '%s\n' "$RESULT"
[[ "$RESULT" == *NEXO_DEPLOY_OK* ]] || { echo 'Deploy não confirmou sucesso. Verifique os logs da VM.' >&2; exit 1; }
