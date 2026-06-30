pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    command:
    - sleep
    args:
    - 9999999
    volumeMounts:
    - name: gcp-key
      mountPath: /secret
  - name: kubectl
    image: google/cloud-sdk:latest
    command:
    - sleep
    args:
    - 9999999
    volumeMounts:
    - name: gcp-key
      mountPath: /secret
  volumes:
  - name: gcp-key
    secret:
      secretName: gcp-sa-key
"""
        }
    }

    environment {
        PROJECT_ID = "devops-portfolio-ivo-2026"
        IMAGE      = "europe-west1-docker.pkg.dev/${PROJECT_ID}/portfolio-repo/portfolio-app"
        TAG        = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Push Image') {
            steps {
                container('kaniko') {
                    sh """
                        /kaniko/executor \
                          --context=`pwd` \
                          --dockerfile=`pwd`/Dockerfile \
                          --destination=${IMAGE}:${TAG} \
                          --destination=${IMAGE}:latest
                    """
                }
            }
        }

        stage('Deploy to GKE') {
            steps {
                container('kubectl') {
                    sh """
                        apt-get install -y kubectl google-cloud-sdk-gke-gcloud-auth-plugin
                        export USE_GKE_GCLOUD_AUTH_PLUGIN=True
                        gcloud auth activate-service-account --key-file=/secret/key.json
                        gcloud container clusters get-credentials portfolio-cluster --zone europe-west1-b --project ${PROJECT_ID}
                        kubectl set image deployment/portfolio-app portfolio-app=${IMAGE}:${TAG}
                        kubectl rollout status deployment/portfolio-app
                    """
                }
            }
        }
    }
}
