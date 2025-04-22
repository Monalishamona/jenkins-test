pipeline {
<<<<<<< HEAD
    agent any
    tools {nodejs "NODEJS"}
=======
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

>>>>>>> d5756159565fa28a90b3fe43b7c79abbd29e90cf
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Deliver') {
            steps {
                sh 'chmod -R +rwx ./jenkins/scripts/deliver.sh'
                sh 'chmod -R +rwx ./jenkins/scripts/kill.sh'
                sh './jenkins/scripts/deliver.sh'
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                sh './jenkins/scripts/kill.sh'
            }
        }
<<<<<<< HEAD
=======

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
>>>>>>> d5756159565fa28a90b3fe43b7c79abbd29e90cf
    }
}
