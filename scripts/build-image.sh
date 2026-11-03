#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
API_REF=${API_REF:-b277672b3ed25ac2bd2970fbd6824dc3d38bae86}
IMAGE=${IMAGE:-nexo-api:sprint1}
[[ "$API_REF" =~ ^[a-f0-9]{40}$ ]] || { echo 'API_REF precisa ser um commit SHA completo.' >&2; exit 1; }
command -v docker >/dev/null
docker info >/dev/null
mkdir -p "$ROOT/.work"
CONTEXT=$(mktemp -d "$ROOT/.work/api.XXXXXX")
trap 'rm -rf -- "$CONTEXT"' EXIT
git -C "$CONTEXT" init -q
git -C "$CONTEXT" remote add origin https://github.com/Nexo-Challenge/s1-java-api.git
git -C "$CONTEXT" fetch --depth 1 origin "$API_REF"
git -C "$CONTEXT" checkout --detach FETCH_HEAD
[[ $(git -C "$CONTEXT" rev-parse HEAD) == "$API_REF" ]]
cp "$ROOT/docker/.dockerignore" "$CONTEXT/.dockerignore"
cp -R "$ROOT/docker/config" "$CONTEXT/nexo-config"
docker build --label "org.opencontainers.image.revision=$API_REF" \
  --label 'org.opencontainers.image.source=https://github.com/Nexo-Challenge/s1-java-api' \
  -f "$ROOT/docker/Dockerfile" -t "$IMAGE" "$CONTEXT"
docker image inspect "$IMAGE" --format 'Imagem criada: {{.Id}} | usuário: {{.Config.User}}'
