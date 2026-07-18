pipeline {
    agent any
    
    environment {
        AWS_ACCOUNT_ID = '183295449692' // Ensure this is your actual account ID
        AWS_REGION     = 'ap-south-1'
        ECR_REPO_NAME  = 'enterprise-banking-app'
        CLUSTER_NAME   = 'banking-production-cluster'
        IMAGE_TAG      = "${BUILD_NUMBER}"
        REGISTRY_URL   = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
    }

    stages {
        stage('Checkout Source') {
            steps {
                checkout scm
            }
        }

        stage('Maven Compile & Package') {
            steps {
                // Installs Maven directly if missing, then runs the package
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Build & Tag') {
            steps {
                script {
                    sh "docker build -t ${REGISTRY_URL}/${ECR_REPO_NAME}:${IMAGE_TAG} ."
                    sh "docker tag ${REGISTRY_URL}/${ECR_REPO_NAME}:${IMAGE_TAG} ${REGISTRY_URL}/${ECR_REPO_NAME}:latest"
                }
            }
        }

        stage('Push Image to Amazon ECR') {
            steps {
                withAWS(credentials: 'aws-credentials-id', region: "${AWS_REGION}") {
                    script {
                        sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${REGISTRY_URL}"
                        sh "docker push ${REGISTRY_URL}/${ECR_REPO_NAME}:${IMAGE_TAG}"
                        sh "docker push ${REGISTRY_URL}/${ECR_REPO_NAME}:latest"
                    }
                }
            }
        }

        stage('Deploy to Amazon EKS') {
            steps {
                withAWS(credentials: 'aws-credentials-id', region: "${AWS_REGION}") {
                    script {
                        sh "aws eks update-kubeconfig --region ${AWS_REGION} --name ${CLUSTER_NAME}"
                        
                        sh "kubectl apply -f k8s/configmap.yaml"
                        sh "kubectl apply -f k8s/secrets.yaml"
                        sh "kubectl apply -f k8s/service.yaml"
                        sh "kubectl apply -f k8s/hpa.yaml"
                        
                        sh "sed -i 's/AWS_ACCOUNT_ID/${AWS_ACCOUNT_ID}/g' k8s/deployment.yaml"
                        sh "sed -i 's/:latest/:${IMAGE_TAG}/g' k8s/deployment.yaml"
                        sh "kubectl apply -f k8s/deployment.yaml"
                        
                        sh "kubectl rollout status deployment/banking-core-deployment --timeout=90s"
                    }
                }
            }
        }
    }
}