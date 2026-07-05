# Exercise 1 – EKS Application Deployment via GitOps

## Scenario

A new microservice called `payment-service` must be deployed to Amazon EKS.

### Target architecture

GitHub → GitHub Actions → ECR → Argo CD → EKS

- Argo CD
- AWS Load Balancer Controller
- External Secrets Operator or an equivalent Secrets Manager integration
- Prometheus Operator / ServiceMonitor support
- Grafana connected to the cluster metrics source

## What you need to build

### 1) Helm chart
Create a chart for `payment-service` that includes at least:

- `Deployment`
- `Service`
- `ServiceAccount`
- `Ingress` with ALB annotations
- `ServiceMonitor` for metrics scraping
- optional `HorizontalPodAutoscaler`

### 2) Argo CD Application
Create an Argo CD `Application` manifest that:

- points to the Helm chart
- enables auto-sync
- enables self-heal and prune
- deploys into a dedicated namespace

### 3) Secrets integration
Create Kubernetes resources that pull the secret from AWS Secrets Manager into the cluster.
A common implementation is:

- `SecretStore` or `ClusterSecretStore`
- `ExternalSecret`

### 4) IRSA
Configure the service account so the pod can assume an IAM role using IRSA.
Add the service account annotation with the role ARN and include the IAM trust/policy skeleton.

### 5) ALB ingress
Expose the application using AWS Load Balancer Controller annotations.

### 6) Metrics
Expose a `/metrics` endpoint and create a `ServiceMonitor` so Grafana can visualize the metrics.

## Acceptance criteria

The exercise is complete when:

- `payment-service` is deployed by Argo CD
- sync is automated
- the application reads its secret from AWS Secrets Manager
- the pod uses IRSA rather than node credentials
- the app is reachable through an ALB Ingress
- metrics appear in Grafana

## Suggested repository structure

- `charts/payment-service/`
- `argocd/application.yaml`
- `external-secrets/`
- `iam/`
- `observability/`

## Starter files

The following files provide a scaffold you can adapt:

- [charts/payment-service/Chart.yaml](charts/payment-service/Chart.yaml)
- [charts/payment-service/values.yaml](charts/payment-service/values.yaml)
- [charts/payment-service/templates/deployment.yaml](charts/payment-service/templates/deployment.yaml)
- [charts/payment-service/templates/service.yaml](charts/payment-service/templates/service.yaml)
- [charts/payment-service/templates/serviceaccount.yaml](charts/payment-service/templates/serviceaccount.yaml)
- [charts/payment-service/templates/ingress.yaml](charts/payment-service/templates/ingress.yaml)
- [charts/payment-service/templates/servicemonitor.yaml](charts/payment-service/templates/servicemonitor.yaml)
- [argocd/application.yaml](argocd/application.yaml)
- [external-secrets/secretstore.yaml](external-secrets/secretstore.yaml)
- [external-secrets/externalsecret.yaml](external-secrets/externalsecret.yaml)
- [iam/irsa-trust-policy.json](iam/irsa-trust-policy.json)
- [observability/servicemonitor.yaml](observability/servicemonitor.yaml)