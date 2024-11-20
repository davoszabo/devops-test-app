pipeline {
    agent any
    
    parameters {
        string(name: 'IMAGE_NAME', defaultValue: '', description: 'Name of the Docker image to deploy')
        string(name: 'REGISTRY_URL', defaultValue: '', description: 'Docker registry URL')
        string(name: 'APP_NAME', defaultValue: '', description: 'Container name')
    }
    
    stages {
        stage('Initialize'){
            steps {
                script {
                    def dockerHome = tool 'myDocker'
                    env.PATH = "${dockerHome}/bin:${env.PATH}"
                }
            }
        }
        
        
        stage('Pull Docker Image') {
            steps {
                script {
                    sh "docker pull ${params.REGISTRY_URL}/${params.IMAGE_NAME}"
                }
            }
        }
        
        stage('Clean-up Docker Container') {
            steps {
                script {
                    sh '''#!/bin/bash
                    docker stop ${APP_NAME} || true && docker rm -f ${APP_NAME} || true
                    '''
                }
            }
        }
        
        stage('Start Docker Container') {
            steps {
                script {
                    // Run the new container
                    sh '''#!/bin/bash
                    docker run -d --name ${APP_NAME} -p 70:70 ${REGISTRY_URL}/${IMAGE_NAME}
                    '''
                }
            }
        }
    }
}

