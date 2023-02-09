pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '''
		docker build -t eu.gcr.io/lbg-cloud-incubation/iamgename:latest -t eu.gcr.io/lbg-cloud-incubation/pyflaskapp:build-$BUILD_NUMBER .
		'''
            }
        }
        stage('Push') {
            steps {
                sh '''
		docker push eu.gcr.io/lbg-cloud-incubation/pyflaskapp:latest
		docker push eu.gcr.io/lbg-cloud-incubation/pyflaskapp:build-$BUILD_NUMBER
		'''
            }
        }
	stage('Stop and Clean') {
            steps {
                script {
			if ("${GIT_BRANCH}" == 'origin/main') {
				sh '''
				ssh -i '/path/to/key/key-name' jenkins@34.155.95.228 << EOF
				docker rm -f containername
				'''
                //need to comment out for our first build 
                //docker rmi eu.gcr.io/lbg-cloud-incubation/pyflaskapp:latest
                
			} else if ("${GIT_BRANCH}" == 'origin/development') {
				sh '''
				ssh -i '/home/jenkins/.ssh/authorized_keys' jenkins@35.228.77.33 << EOF
				docker rm -f containername
				'''
                //need to comment out for our first build 
                //docker rmi eu.gcr.io/lbg-cloud-incubation/pyflaskapp:latest
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
				docker run -d -p 80:5500 --name containername eu.gcr.io/lbg-cloud-incubatione/pyflaskappe:latest
				'''
			} else if ("${GIT_BRANCH}" == 'origin/development') {
				sh '''
				ssh -i '/home/jenkins/.ssh/authorized_keys' jenkins@35.228.77.33 << EOF
				docker run -d -p 80:5500 --name containername eu.gcr.io/lbg-cloud-incubation/pyflaskapp:latest
				'''
			}
		}
            }
        }
    }
}