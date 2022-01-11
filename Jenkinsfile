properties([pipelineTriggers([githubPush()])])
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                git branch: 'main',
                    credentialsId: '79ea8531-b8a6-4a2e-89fd-c51132cd3273',
                    url: 'git@github.com:skiyl9x/LEMP_stack.git'
                sh 'docker build -t l9xhub/wp_mariadb:latest --target img1 .'
                sh 'docker build -t l9xhub/wp_nginx:latest --target img2 .'
                sh 'docker build -t l9xhub/wp_php7-fpm:latest --target img3 .'
            }
        }
        stage('Test') {
            steps {
                sh 'docker images | grep wp_nginx'
                sh 'docker images | grep wp_mariadb'
                sh 'docker images | grep wp_php7-fpm'
                sh 'docker-compose up -d'
                sh 'docker ps'
            }
        }
    }
}
