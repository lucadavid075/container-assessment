#!/bin/bash
set -e

# Delete existing cluster
kind delete cluster --name muchtodo || true

# Create cluster with NodePort mapping
cat <<EOF | kind create cluster --name muchtodo --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 30080
    hostPort: 30080
    protocol: TCP
EOF

# Load Docker image into Kind
kind load docker-image muchtodo-api:latest --name muchtodo

# Deploy to Kubernetes
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/mongodb/
kubectl apply -f kubernetes/backend/
kubectl apply -f kubernetes/ingress.yaml