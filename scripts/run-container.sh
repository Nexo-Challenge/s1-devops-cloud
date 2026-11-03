#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
MODE=${1:-demo}
IMAGE=${IMAGE:-nexo-api:sprint1}
NAME=${CONTAINER_NAME:-nexo-api}
BIND_ADDRESS=${BIND_ADDRESS:-127.0.0.1}
if docker container inspect "$NAME" >/dev/null 2>&1; then
  echo "Container $NAME já existe. Confira-o antes de substituir: docker ps -a" >&2; exit 1
fi
ARGS=(--detach --name "$NAME" --restart unless-stopped --memory 768m --cpus 1
  --security-opt no-new-privileges:true --cap-drop ALL
  --log-opt max-size=10m --log-opt max-file=3
  -e JAVA_TOOL_OPTIONS=-XX:MaxRAMPercentage=65.0 -p "$BIND_ADDRESS:8080:8080")
case "$MODE" in
  demo) ARGS+=(-e SPRING_PROFILES_ACTIVE=demo) ;;
  oracle)
    ENV_FILE=${ORACLE_ENV_FILE:-$ROOT/docker/oracle.env}
    [[ -f "$ENV_FILE" ]] || { echo 'Crie docker/oracle.env a partir do exemplo, fora do Git.' >&2; exit 1; }
    ARGS+=(--env-file "$ENV_FILE") ;;
  *) echo 'Uso: bash scripts/run-container.sh demo|oracle' >&2; exit 1 ;;
esac
docker run "${ARGS[@]}" "$IMAGE"
echo "Container iniciado em modo $MODE. Validar com: bash scripts/verify.sh"
