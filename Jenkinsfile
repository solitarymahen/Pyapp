//jenkinsfile

node{
	git branch: 'main', credentialsId: 'f5602e8f-acc2-4b51-8760-ae42935394b1', url: 'https://github.com/teddmhndr/Pyapp.git'
		
	stage('Pull from Github'){
			sh '''
			cd /var/lib/jenkins/workspace/Pyapp
			aws ecr get-login-password --region ap-southeast-1 |  docker login --username AWS --password-stdin 610068533440.dkr.ecr.ap-southeast-1.amazonaws.com
			docker build -t Pyapp .
			docker tag Pyapp:latest 610068533440.dkr.ecr.ap-southeast-1.amazonaws.com/n2ogaming-github:Pyapp
			'''
        }
        stage('Push to ECR'){
			sh '''
			docker push 610068533440.dkr.ecr.ap-southeast-1.amazonaws.com/n2ogaming-github:Pyapp
			'''
	}

	stage('Deploy to ECS'){
			sh '''
			aws ecs update-service --cluster n2ogaming --service Test --force-new-deployment
			'''
	}    

	

}
