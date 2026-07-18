# Enterprise Banking Application CI/CD & Kubernetes Deployment

A production-grade DevOps pipeline that automates the continuous integration and deployment of a core enterprise banking service to Amazon EKS (Elastic Kubernetes Service). This project demonstrates robust CI/CD principles, container security compliance, infrastructure orchestration, and automated application scaling.

## 🏗️ Architecture Overview
1. **Source Control:** Git workflows managed via GitHub.
2. **Continuous Integration:** Automated build trigger on Jenkins (hosted on AWS EC2) executing test suites and multi-stage Docker builds.
3. **Artifact Management:** Secure container image storage and vulnerability scanning using Amazon ECR (Elastic Container Registry).
4. **Continuous Deployment:** Declarative CD pipeline deploying decoupled resources straight into Amazon EKS.
5. **Orchestration & Scaling:** Dynamic traffic handling inside Kubernetes using Deployments, Services, ConfigMaps, Secrets, and Horizontal Pod Autoscalers (HPA).

---

## 🛠️ Technology Stack
* **Cloud Infrastructure:** AWS (EKS, ECR, EC2, IAM, VPC)
* **Automation/CI-CD:** Jenkins (Declarative Pipelines)
* **Containerization:** Docker (Multi-stage Builds)
* **Orchestration:** Kubernetes (v1.34+)
* **Build Tool:** Maven (Java 17 runtime)
* **Configuration Language:** YAML, Groovy

---

## 📁 Repository Structure
```text
enterprise-banking-eks-pipeline/
├── src/                    # Core Java application source code
├── pom.xml                 # Maven dependencies and build definitions
├── Dockerfile              # Secure multi-stage build manifest
├── Jenkinsfile             # Declarative automation pipeline 
└── k8s/                    # Kubernetes orchestration manifests
    ├── configmap.yaml      # Decoupled environment configurations
    ├── secrets.yaml        # Encrypted environment credentials (Base64)
    ├── deployment.yaml     # Resource limits and execution states
    ├── service.yaml        # Internal networking layer
    └── hpa.yaml            # Horizontal Pod Autoscaler policies