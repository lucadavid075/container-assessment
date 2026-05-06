#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

echo "============================================"
echo " Starting MuchToDo with Docker Compose"
echo "============================================"
docker compose up -d --build

echo ""
sleep 5
docker compose ps

echo ""
echo "✅ Stack is up!"
echo "   API    → http://localhost:3000"
echo "   Health → http://localhost:3000/health"
