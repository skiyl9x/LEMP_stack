
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                git branch: 'main', 
                    credentialsId: 'eb41fdb4-beeb-428a-9c0e-20b054fd2597', 
                    url: 'git@github.com:skiyl9x/LEMP_stack.git'
                sh '''
                    docker build -t l9xhub/wp_mariadb10:latest --target img1 .
                    docker build -t l9xhub/wp_nginx:latest --target img2 .
                    docker build -t l9xhub/wp_php7-fpm:latest --target img3 .
                '''
            }
        }
        stage('Test') {
            steps {
                sh '''
                    docker images | grep wp_nginx
                    docker images | grep wp_mariadb
                    docker images | grep wp_php7-fpm
                    docker-compose up -d
                    docker ps
                '''
            }
        }
    }
}
