pipeline {
    agent any
    
    # parameters {
    #     string(name: 'IMAGE_NAME', defaultValue: '', description: 'Name of the Docker image to deploy')
    #     string(name: 'REGISTRY_URL', defaultValue: '', description: 'Docker registry URL')
    # }

    stages {
        stage('Initialize'){
            steps {
                script {
                    def dockerHome = tool 'myDocker'
                    env.PATH = "${dockerHome}/bin:${env.PATH}"
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    customImage = docker.build("${IMAGE_NAME}:${BUILD_ID}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry("http://${REGISTRY_URL}", '') {
                        customImage.push('latest')
                        customImage.push("${BUILD_ID}")
                    }
                }
            }
        }
    }

    post {
        success {
            script {
                // Trigger the deploy job with parameters
                build job: 'deploy-app', parameters: [
                    string(name: 'IMAGE_NAME', value: "${IMAGE_NAME}:${env.BUILD_ID}"),
                    string(name: 'REGISTRY_URL', value: "${REGISTRY_URL}"),
                    string(name: 'APP_NAME', value: "devops-test-app")
                ]
            }
        }
    }
}


