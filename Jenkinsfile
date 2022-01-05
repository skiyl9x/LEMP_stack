properties([pipelineTriggers([githubPush()])])

pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                
                git branch: 'main',
                    credentialsId: 'eb41fdb4-beeb-428a-9c0e-20b054fd2597',
                    url: 'git@github.com:skiyl9x/LEMP_stack.git'
                sh 'docker build -t l9xhub/mariadb:latest --target img1 .'
                sh 'docker build -t l9xhub/nginx:latest --target img2 .'
                sh 'docker build -t l9xhub/php-fpm:latest --target img3 .'
            }
        }
        stage('Test') {
            steps {
                sh 'docker images | grep nginx'
                sh 'docker images | grep mariadb'
                sh 'docker images | grep php-fpm'
                sh 'docker-compose up -d'
                sh 'docker ps'
            }
        }
    }
}

