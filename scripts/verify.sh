#!/usr/bin/env bash
set -euo pipefail
BASE_URL=${BASE_URL:-http://127.0.0.1:8080}
curl --fail --silent --show-error --retry 30 --retry-connrefused --retry-all-errors --retry-delay 2 \
  --connect-timeout 3 --max-time 10 "$BASE_URL/v3/api-docs" -o /dev/null
for path in /swagger-ui/index.html /api/aplicacoes /api/areas; do
  code=$(curl --silent --show-error --connect-timeout 3 --max-time 10 -o /dev/null -w '%{http_code}' "$BASE_URL$path")
  [[ "$code" == 200 ]] || { echo "Falha HTTP $code: $path" >&2; exit 1; }
  echo "HTTP $code $path"
done
echo 'HTTP 200 /v3/api-docs'
