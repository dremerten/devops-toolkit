# DevOps-Toolkit Architecture

## k3s Cluster Architecture
## Technology Stack

| Layer | Technology |
|-------|-----------|
| Container Runtime | containerd |
| Orchestration | k3s (Kubernetes) |
| Gateway | NGINX Gateway Fabric (Gateway API) |
| TLS Management | cert-manager + Let's Encrypt |
| Monitoring | Prometheus + Grafana |
| Metrics | Node Exporter, cAdvisor |
| Package Manager | Helm 3 |
| Load Balancer | NodePort (external LB optional) |
| Storage | Local path provisioner |
| Network | Flannel (default k3s CNI) |

## Summary

✅ **Simple**: Single-node k3s cluster
✅ **Secure**: TLS everywhere, automatic cert renewal
✅ **Scalable**: Multi-replica deployments
✅ **Observable**: Full monitoring stack
✅ **Maintainable**: GitOps-ready, all IaC
✅ **Production-Ready**: Health checks, resource limits, rolling updates

**This architecture demonstrates modern cloud-native practices suitable for a Platform/DevOps Engineer portfolio.**


```
┌─────────────────────────────────────────────────────┐
│                  VPS (Ubuntu 22.04)                 │
│                                                      │
│  ┌────────────────────────────────────────────────┐ │
│  │          k3s Cluster (Single Node)             │ │
│  │                                                 │ │
│  │  ┌──────────────────────────────────────────┐  │ │
│  │  │    NGINX Gateway Fabric (Gateway API)    │  │ │
│  │  │    - Terminates TLS via cert-manager     │  │ │
│  │  │    - Routes based on HTTPRoute hostnames │  │ │
│  │  └──────────────────────────────────────────┘  │ │
│  │                                                 │ │
│  │  ┌──────────────────────────────────────────┐  │ │
│  │  │    cert-manager                          │  │ │
│  │  │    - Let's Encrypt integration           │  │ │
│  │  │    - Automatic TLS certificate issuance  │  │ │
│  │  └──────────────────────────────────────────┘  │ │
│  │                                                 │ │
│  │  Namespaces:                                    │ │
│  │  ├─ devops-toolkit-production                   │ │
│  │  │   └─ devops-toolkit pods (2 replicas)       │ │
│  │  ├─ devops-toolkit-staging                      │ │
│  │  │   └─ devops-toolkit pods (2 replicas)       │ │
│  │  ├─ devops-toolkit-qa                           │ │
│  │  │   └─ devops-toolkit pods (2 replicas)       │ │
│  │  ├─ devops-toolkit-dev                          │ │
│  │  │   └─ devops-toolkit pods (2 replicas)       │ │
│  │  └─ monitoring                                  │ │
│  │      ├─ prometheus                              │ │
│  │      ├─ grafana                                 │ │
│  │      ├─ node-exporter                           │ │
│  │      └─ cadvisor                                │ │
│  └────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────┘
```

## Nginx Flow

```
Internet (HTTPS)
    ↓
NGINX Gateway Fabric (Gateway API)
    ↓ (host-based routing via HTTPRoute)
    ├─ devops-toolkit.dremer10.com → devops-toolkit-production/devops-toolkit
    ├─ staging-devops-toolkit.dremer10.com → devops-toolkit-staging/devops-toolkit
    ├─ qa-devops-toolkit.dremer10.com → devops-toolkit-qa/devops-toolkit
    ├─ dev-devops-toolkit.dremer10.com → devops-toolkit-dev/devops-toolkit
    └─ grafana.devops-toolkit.dremer10.com → monitoring/grafana
```
**Gateway API / NGINX Gateway Fabric Flow**
- Gateway listener terminates TLS with cert-manager-issued secrets (in `nginx-gateway`).
- HTTPRoute objects live in each `devops-toolkit-*` namespace and bind to the shared Gateway via `parentRefs`.
- BackendRefs point to namespace-local services (no cross-namespace hops).
- Migration note: legacy ingress controller removed; traffic now lands on NGINX Gateway Fabric exclusively via HTTPRoute.

## Components

### k3s Cluster
- **Type**: Single-node cluster (control-plane + worker combined)

### NGINX Gateway Fabric (Gateway API)
- **Type**: Gateway API controller
- **Listener**: TLS termination with cert-manager secrets (namespace: `nginx-gateway`)
- **Routing**: HTTPRoute per environment (in `devops-toolkit-*` namespaces) with host-based matching

### cert-manager
- **Purpose**: Automatic TLS certificate management
- **Provider**: Let's Encrypt (ACME)
- **Issuer**: ClusterIssuer `letsencrypt-prod`
- **Challenge**: HTTP-01

### Namespaces

| Namespace | Purpose | Workloads |
|-----------|---------|-----------|
| devops-toolkit-production | Production environment | 2x devops-toolkit pods |
| devops-toolkit-staging | Staging environment | 2x devops-toolkit pods |
| devops-toolkit-qa | QA environment | 2x devops-toolkit pods |
| devops-toolkit-dev | Development environment | 2x devops-toolkit pods |
| monitoring | Observability stack | Prometheus, Grafana, exporters |
| ci-cd | CI/CD tools | Reserved (currently unused) |
| nginx-gateway | Gateway API controller | NGINX Gateway Fabric |
| cert-manager | Certificate management | cert-manager |

## Network Ports

| Port | Protocol | Purpose | Access |
|------|----------|---------|--------|
| xxxx | TCP | k3s API Server | kubectl from laptop |
| xxxxx | TCP | Gateway listener (HTTP) | External (NodePort/LoadBalancer) |
| xxxxx | TCP | Gateway listener (HTTPS) | External (NodePort/LoadBalancer) |
| xxxxx | TCP | Kubelet metrics | Internal |
| xxxxx | UDP | Flannel VXLAN | Internal |

## Gateway API Configuration

- **Gateway**: NGINX Gateway Fabric in `nginx-gateway`, TLS via cert-manager
- **HTTPRoute**: One per environment in each `devops-toolkit-*` namespace, attached via `parentRefs`
- **BackendRef**: Points to namespace-local service `devops-toolkit`
- **Migration note**: Replaced legacy ingress objects with Gateway API HTTPRoutes; the former ingress controller is removed.

## Security

### TLS/SSL
- All traffic encrypted via HTTPS
- Automatic certificate renewal (cert-manager)
- Let's Encrypt certificates (90-day validity, auto-renewed)

### Network Policies
- Namespace isolation
- Default deny ingress/egress (can be configured)

### RBAC
- Role-based access control for kubectl
- ServiceAccount per deployment

## Monitoring Stack

### Prometheus
- **Endpoint**: Internal cluster
- **Scrape Interval**: 30s
- **Retention**: 15 days
- **Storage**: 20Gi PVC

### Grafana
- **Endpoint**: https://grafana.devops-toolkit.dremer10.com
- **Datasource**: Prometheus
- **Dashboards**: Pre-configured

### Exporters
- **Node Exporter**: System metrics (CPU, RAM, disk, network)
- **cAdvisor**: Container metrics
- **kube-state-metrics**: Kubernetes object metrics (optional)

## High Availability Considerations

Current setup is **single-node** for cost efficiency.

## Deployment Strategy

### Rolling Update
```yaml
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxSurge: 1
    maxUnavailable: 0
```

### Health Checks
- **Liveness Probe**: HTTP GET / every 30s
- **Readiness Probe**: HTTP GET / every 10s
- **Startup Delay**: 10s (liveness), 5s (readiness)

## Scaling

### Manual Scaling
```bash
kubectl scale deployment/devops-toolkit --replicas=5 -n devops-toolkit-production
```

### Auto-Scaling (Optional)
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
spec:
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
```

## Backup Strategy

### kubeconfig
- Stored at `~/.kube/config
- Backup: `scp root@VPS:/etc/rancher/k3s/k3s.yaml backup/`

### Cluster State
```bash
# Backup all manifests
kubectl get all,httproutes,certificates -A -o yaml > cluster-backup.yaml
```

## Performance Optimization

### Image Optimization
- Multi-stage Docker builds
- Alpine Linux base images
- Layer caching

### Network
- NodePort for external access
- ClusterIP for internal services
- Service mesh (optional): Linkerd/Istio

### Resource Limits
- All pods have resource requests/limits
- Prevents resource exhaustion
- Enables quality scheduling
