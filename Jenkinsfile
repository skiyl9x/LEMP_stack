properties([pipelineTriggers([githubPush()])])

pipeline {
    agent { dockerfile true }
    stages {
        stage('Test') {
            steps {
                sh 'sudo docker ps'
            }
        }
    }
}
