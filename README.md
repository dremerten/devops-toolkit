# DevOps-Toolkit Architecture

## k3s Cluster Architecture
## Technology Stack

| Layer | Technology |
|-------|-----------|
| Container Runtime | containerd |
| Orchestration | k3s (Kubernetes) |
| Ingress | NGINX Ingress Controller |
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
│  │  │    NGINX Ingress Controller              │  │ │
│  │  │    - NodePort 30080 (HTTP)               │  │ │
│  │  │    - NodePort 30443 (HTTPS)              │  │ │
│  │  │    - Routes based on Host headers        │  │ │
│  │  └──────────────────────────────────────────┘  │ │
│  │                                                 │ │
│  │  ┌──────────────────────────────────────────┐  │ │
│  │  │    cert-manager                          │  │ │
│  │  │    - Let's Encrypt integration           │  │ │
│  │  │    - Automatic TLS certificate issuance  │  │ │
│  │  └──────────────────────────────────────────┘  │ │
│  │                                                 │ │
│  │  Namespaces:                                    │ │
│  │  ├─ production                                  │ │
│  │  │   └─ devops-toolkit pods (2 replicas)       │ │
│  │  ├─ staging                                     │ │
│  │  │   └─ devops-toolkit pods (2 replicas)       │ │
│  │  ├─ qa                                          │ │
│  │  │   └─ devops-toolkit pods (2 replicas)       │ │
│  │  ├─ dev                                         │ │
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
Port 30080 (HTTP) / 30443 (HTTPS)
    ↓
NGINX Ingress Controller
    ↓ (routes based on Host header)
    ├─ devops-toolkit.dremer10.com → production/devops-toolkit
    ├─ staging-devops-toolkit.dremer10.com → staging/devops-toolkit
    ├─ qa-devops-toolkit.dremer10.com → qa/devops-toolkit
    ├─ dev-devops-toolkit.dremer10.com → dev/devops-toolkit
    └─ grafana.devops-toolkit.dremer10.com → monitoring/grafana
```

## Components

### k3s Cluster
- **Type**: Single-node cluster (control-plane + worker combined)
- **Version**: v1.28.5+k3s1 or latest

### NGINX Ingress Controller
- **Type**: Kubernetes Ingress Controller
- **Service Type**: NodePort
- **HTTP Port**: xxxxx
- **HTTPS Port**: xxxxx
- **Configuration**: `ingressClassName: nginx`

### cert-manager
- **Purpose**: Automatic TLS certificate management
- **Provider**: Let's Encrypt (ACME)
- **Issuer**: ClusterIssuer `letsencrypt-prod`
- **Challenge**: HTTP-01

### Namespaces

| Namespace | Purpose | Workloads |
|-----------|---------|-----------|
| production | Production environment | 2x devops-toolkit pods |
| staging | Staging environment | 2x devops-toolkit pods |
| qa | QA environment | 2x devops-toolkit pods |
| dev | Development environment | 2x devops-toolkit pods |
| monitoring | Observability stack | Prometheus, Grafana, exporters |
| ci-cd | CI/CD tools | Jenkins (optional) |
| ingress-nginx | Ingress controller | NGINX Ingress Controller |
| cert-manager | Certificate management | cert-manager |

## Network Ports

| Port | Protocol | Purpose | Access |
|------|----------|---------|--------|
| xxxx | TCP | k3s API Server | kubectl from laptop |
| xxxxx | TCP | NGINX Ingress HTTP | External (NodePort) |
| xxxxx | TCP | NGINX Ingress HTTPS | External (NodePort) |
| xxxxx | TCP | Kubelet metrics | Internal |
| xxxxx | UDP | Flannel VXLAN | Internal |

## Ingress Configuration

All ingresses use:
- **IngressClass**: `nginx`
- **TLS**: Enabled via cert-manager
- **Annotations**:
  - `cert-manager.io/cluster-issuer: "letsencrypt-prod"`
  - `nginx.ingress.kubernetes.io/ssl-redirect: "true"`
  - `nginx.ingress.kubernetes.io/force-ssl-redirect: "true"`

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

Current setup is **single-node** for cost efficiency. For HA:

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
kubectl scale deployment/devops-toolkit --replicas=5 -n production
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
kubectl get all,ingress,certificates -A -o yaml > cluster-backup.yaml
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
