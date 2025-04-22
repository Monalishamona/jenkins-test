pipeline {
    agent {
        docker {
            image 'node:18-alpine'
            args '-v /var/run/docker.sock:/var/run/docker.sock -p 3000:3000'
        }
    }

    environment {
        DOCKER_IMAGE = "monalishaa/react-app"
        DOCKER_TAG = "${env.BUILD_ID}"
        REGISTRY_CREDENTIALS = 'dockerhub-credentials'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Monalishamona/jenkins-test.git'
            }
        }

        stage('Install & Build') {
            steps {
                sh 'npm ci'
                sh 'npm run build'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test -- --watchAll=false --ci'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Push to Docker Registry') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', REGISTRY_CREDENTIALS) {
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                    }
                }
            }
        }
    }

    post {
        always {
            node('') {
                echo 'Cleaning up workspace...'
                deleteDir()
            }
        }
        success {
            echo 'Docker image pushed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
