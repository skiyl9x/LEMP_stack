properties([pipelineTriggers([githubPush()])])

pipeline {
    agent any
    stages {
        stage('Deploy by docker-compose') {
            when {
            	branch "main"
            }

            steps {
                git branch: 'main',
                    credentialsId: 'eb41fdb4-beeb-428a-9c0e-20b054fd2597',
                    url: 'git@github.com:skiyl9x/LEMP_stack.git'
                   sh './deploy.sh'
            }
        }
        stage('Test') {
	    when {
         	branch "main"
            }

            steps {
                sh './test.sh'
            }
        }
	stage('Deploy app to k8s') {
            when {
    	        branch "production"
            }

	    steps {
                git branch: 'production',
                    credentialsId: 'eb41fdb4-beeb-428a-9c0e-20b054fd2597',
                    url: 'git@github.com:skiyl9x/LEMP_stack.git'

		sh './deploy_to_k8s.sh'
            }
	}
	stage('Deploy moitoring') {
            when {
    	        branch "production"
            }

	    steps {
		sh './monitoring.sh'
	    }
	}
	stage('Test app in k8s'){
            when {
    	        branch "production"
            }

	    steps {
		sh './test-k8s.sh'
	    }
	}
    }
}

