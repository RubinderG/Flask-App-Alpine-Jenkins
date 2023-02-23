pipeline {
    agent any
    stages {
        stage('Build Flask App') {
            steps {
                script {
			        if ("${GIT_BRANCH}" == 'origin/main') {
				        sh '''
                        echo "Skipping due to main branch"
				        '''
			        } else if ("${GIT_BRANCH}" == 'origin/development') {
				        sh '''
				        docker build -t eu.gcr.io/lbg-cloud-incubation/rkg-flask-alpine:latest -t eu.gcr.io/lbg-cloud-incubation/rkg-flask-alpine:build-$BUILD_NUMBER .
				        '''
			        } 
		        }
           }
        }
        stage('Build Custom NGINX') {
            steps {
                script {
			        if ("${GIT_BRANCH}" == 'origin/main') {
				        sh '''
                        echo "Skipping due to main branch"
				        '''
			        } else if ("${GIT_BRANCH}" == 'origin/development') {
				        sh '''
                        cd ./nginx
                        docker build -t eu.gcr.io/lbg-cloud-incubation/rkg-nginx-alpine:latest -t eu.gcr.io/lbg-cloud-incubation/rkg-nginx-alpine:build-$BUILD_NUMBER .
				        '''
			        } 
                }
           }
        }
        stage('Push Images') {
            steps {
                script {
			        if ("${GIT_BRANCH}" == 'origin/main') {
				        sh '''
                        echo "Skipping due to main branch"
				        '''
			        } else if ("${GIT_BRANCH}" == 'origin/development') {
				        sh '''
                        docker push eu.gcr.io/lbg-cloud-incubation/rkg-flask-alpine:latest
                        docker push eu.gcr.io/lbg-cloud-incubation/rkg-flask-alpine:build-$BUILD_NUMBER
                        docker push eu.gcr.io/lbg-cloud-incubation/rkg-nginx-alpine:latest
                        docker push eu.gcr.io/lbg-cloud-incubation/rkg-nginx-alpine:build-$BUILD_NUMBER
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
                        cd ./kubernetes
				        sed -e 's,{{ns}},production,g;' flask-app.yml | kubectl apply -f -
                        sed -e 's,{{ns}},production,g;' nginx.yml | kubectl apply -f -
                        kubectl rollout restart deployment --namespace=production flask-deployment
                        kubectl rollout restart deployment --namespace=production nginx-deployment
				        '''
			        } else if ("${GIT_BRANCH}" == 'origin/development') {
				        sh '''
				        cd ./kubernetes
				        sed -e 's,{{ns}},development,g;' flask-app.yml | kubectl apply -f -
                        sed -e 's,{{ns}},development,g;' nginx.yml | kubectl apply -f -
                        kubectl rollout restart deployment --namespace=development flask-deployment
                        kubectl rollout restart deployment --namespace=development nginx-deployment
				        '''
			        } 
		        }
                
            }
        }
        stage('Clean Up') {
            steps {
                sh 'docker system prune -f'
            } 
        }
    }
}
// pipeline {
//     agent any
//     stages {
//         stage('Build Flask App') {
//             steps {
//                 sh '''
//                 docker build -t eu.gcr.io/lbg-cloud-incubation/rkg-flask-alpine:latest -t eu.gcr.io/lbg-cloud-incubation/rkg-flask-alpine:build-$BUILD_NUMBER .
//                 '''
//            }
//         }
//         stage('Build Custom NGINX') {
//             steps {
//                 sh '''
//                 cd ./nginx
//                 docker build -t eu.gcr.io/lbg-cloud-incubation/rkg-nginx-alpine:latest -t eu.gcr.io/lbg-cloud-incubation/rkg-nginx-alpine:build-$BUILD_NUMBER .
//                 '''
//            }
//         }
//         stage('Push Images') {
//             steps {
//                 sh '''
//                 docker push eu.gcr.io/lbg-cloud-incubation/rkg-flask-alpine:latest
//                 docker push eu.gcr.io/lbg-cloud-incubation/rkg-flask-alpine:build-$BUILD_NUMBER
//                 docker push eu.gcr.io/lbg-cloud-incubation/rkg-nginx-alpine:latest
//                 docker push eu.gcr.io/lbg-cloud-incubation/rkg-nginx-alpine:build-$BUILD_NUMBER
//                 '''
//             }
//         }
//         stage('Deploy') {
//             steps {
//                 sh '''
//                 cd ./kubernetes
//                 kubectl apply -f .
//                 kubectl rollout restart deployment flask-deployment
//                 kubectl rollout restart deployment nginx-deployment
//                 '''
//             }
//         }
//     }
// }