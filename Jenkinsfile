properties([pipelineTriggers([githubPush()])])

node {
    stage ('Checkout'){
        git branch: 'exampleBranch', url: 'https://github.com/example-org/example-repo.git'
    }
    stage ('Build'){
        // steps
    }
    stage ('Test'){
        // steps
    }
}    
