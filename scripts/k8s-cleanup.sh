#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
K8S_DIR="${ROOT_DIR}/kubernetes"
NS="muchtodo"
CLUSTER="muchtodo"

echo "▶  Removing Kubernetes resources..."
kubectl delete -n "${NS}" -f "${K8S_DIR}/ingress.yaml"          --ignore-not-found
kubectl delete -n "${NS}" -f "${K8S_DIR}/backend/"              --ignore-not-found
kubectl delete -n "${NS}" -f "${K8S_DIR}/mongodb/"              --ignore-not-found
kubectl delete -f "${K8S_DIR}/namespace.yaml"                   --ignore-not-found
echo "✅ Done."
echo ""
echo "To delete the Kind cluster too:"
echo "  kind delete cluster --name ${CLUSTER}"
