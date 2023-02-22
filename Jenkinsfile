pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '''
		        docker build -t eu.gcr.io/lbg-cloud-incubation/simpleflask:latest -t eu.gcr.io/lbg-cloud-incubation/simpleflask:build-$BUILD_NUMBER .
		        '''
            }
        }
        stage('Push') {
            steps {
                sh '''
		        docker push eu.gcr.io/lbg-cloud-incubation/simpleflask:latest
		        docker push eu.gcr.io/lbg-cloud-incubation/simpleflask:build-$BUILD_NUMBER
		        '''
            }
        }
	stage('Stop and Clean') {
            steps {
                script {
			        if ("${GIT_BRANCH}" == 'origin/main') {
				        sh '''
				        ssh -i '/home/jenkins/.ssh/authorized_keys' jenkins@34.155.95.228 << EOF
				        docker rm -f flaskapp
					docker rmi eu.gcr.io/lbg-cloud-incubation/simpleflask:latest
				        '''
			        } else if ("${GIT_BRANCH}" == 'origin/development') {
				        sh '''
				        ssh -i '/home/jenkins/.ssh/authorized_keys' jenkins@35.228.77.33 << EOF
				        docker rm -f flaskapp
					docker rmi eu.gcr.io/lbg-cloud-incubation/simpleflask:lates
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
				        ssh -i '/home/jenkins/.ssh/authorized_keys' jenkins@34.155.95.228 << EOF
				        docker run -d -p 80:5500 --name flaskapp eu.gcr.io/lbg-cloud-incubation/simpleflask:latest
				        '''
			        } else if ("${GIT_BRANCH}" == 'origin/development') {
				        sh '''
				        ssh -i '/home/jenkins/.ssh/authorized_keys' jenkins@35.228.77.33 << EOF
				        docker run -d -p 80:5500 --name flaskapp eu.gcr.io/lbg-cloud-incubation/simpleflask:latest
				        '''
			        }
                }
            }
        }
    }
}
