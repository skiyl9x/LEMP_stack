properties([pipelineTriggers([githubPush()])])

pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                sh 'sudo docker ps'
            }
        }
    }
}
