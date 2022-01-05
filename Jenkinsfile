properties([pipelineTriggers([githubPush()])])

pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t l9xhub/jenkins:latest'
            }
        }
        stage('Test') {
            steps {
                sh 'docker images'
            }
        }
    }
}
