properties([pipelineTriggers([githubPush()])])

pipeline {
    agent any
    stages {
        stage('Deploy_by_docker-compose') {
            steps {
                git branch: 'main',
                    credentialsId: 'eb41fdb4-beeb-428a-9c0e-20b054fd2597',
                    url: 'git@github.com:skiyl9x/LEMP_stack.git'
                   sh './deploy.sh'
            }
        }
        stage('Test') {
            steps {
                sh './test.sh'
            }
        }
	stage('Deploy app to k8s') {
	    steps {
		sh './deploy_to_k8s.sh'
            }
	}
	stage('Deploy moitoring') {
	    steps {
		sh './prometheus_and_grafana.sh'
	    }
	}
	
    }
}
