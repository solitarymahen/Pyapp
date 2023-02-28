//jenkinsfile
pipeline {
 agent any
 environment {
  GIT_AUTHOR_NAME = "${env.GIT_AUTHOR_NAME}"
  GIT_COMMITTER_NAME = "${env.GIT_COMMITTER_NAME}"
  CDD_APPLICATION_VERSION_NAME = "${env.GIT_BRANCH}"
  CDD_GIT_COMMIT_ID = "${env.GIT_COMMIT}"
  CDD_PREVIOUS_GIT_COMMIT_ID = "${env.GIT_PREVIOUS_SUCCESSFUL_COMMIT}"
  GIT_BRANCH = "${env.GIT_BRANCH}"
  BRANCH_NAME = "${env.BRANCH_NAME}"
  GIT_LOCAL_BRANCH = "${env.GIT_LOCAL_BRANCH}"
 }
    stages {
        stage("Get git information") {
            steps {
                script {
                    env.GIT_COMMIT_MSG = sh (script: 'git log -1 --pretty=%B ${GIT_COMMIT}', returnStdout: true).trim()
                    env.GIT_COMMITTER = sh (script: 'git show -s --pretty=%an', returnStdout: true).trim()
                }
            }
        }

}


node{
	git branch: 'main', credentialsId: '745a6d6a-e47d-4f65-984d-285a959fdf9a', url: 'https://github.com/teddmhndr/Pyapp.git'
		
	stage('Pull from Github'){
			sh '''
			echo %0a%0a%22$GIT_COMMIT_MSG%22%0a-$GIT_COMMITTER
			cd /var/lib/jenkins/workspace/Testing
			aws ecr get-login-password --region ap-southeast-1 |  docker login --username AWS --password-stdin 610068533440.dkr.ecr.ap-southeast-1.amazonaws.com
			docker build -t pyapp .
			docker tag pyapp:latest 610068533440.dkr.ecr.ap-southeast-1.amazonaws.com/n2ogaming-github:pyapp
			'''
        }
        stage('Push to ECR'){
			sh '''
			docker push 610068533440.dkr.ecr.ap-southeast-1.amazonaws.com/n2ogaming-github:pyapp
			'''
	}

	stage('Deploy to ECS'){
			sh '''
			aws ecs update-service --cluster n2ogaming --service Test --force-new-deployment
			'''
	}    

	

}
