pipeline {
    agent any
    stages {
        stage('Build Flask App') {
            steps {
                sh '''
                docker build -t rubinder/flask-app:latest -t rubinder/flask-app:build-$BUILD_NUMBER .
                '''
           }
        }
        stage('Build Custom NGINX') {
            steps {
                sh '''
                cd ./nginx
                docker build -t rubinder/nginx-custom:latest -t rubinder/nginx-custom:build-$BUILD_NUMBER .
                '''
           }
        }
        stage('Push Images') {
            steps {
                sh '''
                docker push rubinder/flask-app:latest
                docker push rubinder/flask-app:latest:build-$BUILD_NUMBER
                docker push rubinder/nginx-custom:latest
                docker push rubinder/nginx-custom:build-$BUILD_NUMBER
                '''
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                cd ./kubernetes
                kubectl apply -f .
                '''
            }
        }
    }
}