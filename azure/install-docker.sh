#!/usr/bin/env bash
# Executar dentro de uma VM Ubuntu dedicada ao NEXO.
set -euo pipefail
if command -v docker >/dev/null; then
  sudo systemctl enable --now docker
  sudo docker info >/dev/null
  exit 0
fi
. /etc/os-release
[[ "$ID" == ubuntu ]] || { echo 'Este script requer Ubuntu.' >&2; exit 1; }
sudo apt-get update
sudo apt-get install -y ca-certificates curl git
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
ARCH=$(dpkg --print-architecture)
CODENAME=${UBUNTU_CODENAME:-$VERSION_CODENAME}
printf '%s\n' 'Types: deb' 'URIs: https://download.docker.com/linux/ubuntu' \
  "Suites: $CODENAME" 'Components: stable' "Architectures: $ARCH" \
  'Signed-By: /etc/apt/keyrings/docker.asc' | sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo docker version
