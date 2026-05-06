# MuchToDo – Container Assessment

## Structure
```
container-assessment/
├── application-code/
│   ├── MuchToDo/
│   │    ├── cmd/api/  # Application entrypoint
│   │    ├── docs/     # Swagger docs
│   │    ├── internal/ # Application source code
│   │    ├── go.mod
│        └── go.sum      
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── kubernetes/
│   ├── namespace.yaml
│   ├── mongodb/
│   │   ├── mongodb-secret.yaml
│   │   ├── mongodb-configmap.yaml
│   │   ├── mongodb-pvc.yaml
│   │   ├── mongodb-deployment.yaml
│   │   └── mongodb-service.yaml
│   ├── backend/
│   │   ├── backend-secret.yaml
│   │   ├── backend-configmap.yaml
│   │   ├── backend-deployment.yaml
│   │   └── backend-service.yaml
│   └── ingress.yaml
├── scripts/
│   ├── docker-build.sh
│   ├── docker-run.sh
│   ├── k8s-deploy.sh
│   └── k8s-cleanup.sh
└── README.md
```

## Phase 1 – Docker

```bash
# Build
bash scripts/docker-build.sh

# Run
bash scripts/docker-run.sh

# Test
curl http://localhost:3000/health
curl http://localhost:3000/ping
```

## Phase 2 – Kubernetes (Kind)

```bash
# Deploy everything (creates cluster, builds image, deploys)
bash scripts/k8s-deploy.sh

# Check status
kubectl get pods    -n muchtodo
kubectl get svc     -n muchtodo
kubectl get ingress -n muchtodo

# Test via NodePort
curl http://localhost:30080/health

# Test via Ingress
echo "127.0.0.1 muchtodo.local" | sudo tee -a /etc/hosts
curl http://muchtodo.local:8080/health

# Cleanup
bash scripts/k8s-cleanup.sh
kind delete cluster --name muchtodo
```
