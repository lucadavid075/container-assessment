#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE="muchtodo-backend:latest"

echo "============================================"
echo " Building Docker image: ${IMAGE}"
echo "============================================"
docker build -t "${IMAGE}" "${ROOT_DIR}"
echo "✅ Build complete: ${IMAGE}"
docker images muchtodo-backend
