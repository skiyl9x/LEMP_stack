properties([pipelineTriggers([githubPush()])])

pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                sh 'docker build -t l9xhub/jenkins:latest'
                sh 'docker images'
            }
        }
    }
}
