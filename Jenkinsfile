pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '''
		docker build -t gcr.io/project-name/iamgename:latest -t gcr.io/project-name/iamgename:build-$BUILD_NUMBER .
		'''
            }
        }
        stage('Push') {
            steps {
                sh '''
		docker push gcr.io/project-name/iamgename:latest
		docker push gcr.io/project-name/iamgename:build-$BUILD_NUMBER
		'''
            }
        }
	stage('Stop and Clean') {
            steps {
                script {
			if ("${GIT_BRANCH}" == 'origin/main') {
				sh '''
				ssh -i '/path/to/key/key-name' jenkins@PROD-IP << EOF
				docker rm -f containername
				docker rmi gcr.io/project-name/iamgename:latest
				'''
			} else if ("${GIT_BRANCH}" == 'origin/development') {
				sh '''
				ssh -i '/path/to/key/key-name' jenkins@DEV-IP << EOF
				docker rm -f containername
				docker rmi gcr.io/project-name/iamgename:latest
				'''
			}
		}
            }
        }
        stage('Deploy') {
            steps {
                script {
			if ("${GIT_BRANCH}" == 'origin/main') {
				sh '''
				ssh -i '/path/to/key/key-name' jenkins@PROD-IP << EOF
				docker run -d -p 80:5500 --name containername gcr.io/project-name/iamgename:latest
				'''
			} else if ("${GIT_BRANCH}" == 'origin/development') {
				sh '''
				ssh -i '/path/to/key/key-name' jenkins@DEV-IP << EOF
				docker run -d -p 80:5500 --name containername gcr.io/project-name/iamgename:latest
				'''
			}
		}
            }
        }
    }
}