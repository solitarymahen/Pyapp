//jenkinsfile
pipeline {
 agent any
 environment {
  GIT_COMMITER = "${env.GIT_COMMITER}"
  CDD_APPLICATION_VERSION_NAME = "${env.GIT_BRANCH}"
  CDD_GIT_COMMIT_ID = "${env.GIT_COMMIT}"
  CDD_PREVIOUS_GIT_COMMIT_ID = "${env.GIT_PREVIOUS_SUCCESSFUL_COMMIT}"
  GIT_BRANCH = "${env.GIT_BRANCH}"
  BRANCH_NAME = "${env.BRANCH_NAME}"
  GIT_LOCAL_BRANCH = "${env.GIT_LOCAL_BRANCH}"
 }
 stages {
  stage("Stage Name") {
   steps {
    echo '**** Build ****'
   }
  }
 }
 post {
  success {
   echo '----------Sending Build Notification to CDD--------------'
   echo "Environment variables: GIT_BRANCH: [$GIT_BRANCH], BRANCH_NAME: [$GIT_COMMITER], GIT_LOCAL_BRANCH: [$GIT_LOCAL_BRANCH]"
    echo '----------CloudBees Jenkins Pipeline completed successfully--------------'
  }
 }
}


node{
	git branch: 'main', credentialsId: '745a6d6a-e47d-4f65-984d-285a959fdf9a', url: 'https://github.com/teddmhndr/Pyapp.git'
		
	stage('Pull from Github'){
			sh '''
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
