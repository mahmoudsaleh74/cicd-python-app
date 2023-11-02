pipeline{
    agent any

    environment {
        DOCKER_HUB_REPO = 'mahmoudsaleh' // Use docker hub
        DOCKER_IMAGE_NAME = 'python-app' 
        DOCKER_IMAGE_TAG = "v${BUILD_NUMBER}" // Use the build number as the Docker image tag
    		}

    stages{
        stage('build'){
            steps{
                script{
                    sh 'docker build -t $DOCKER_IMAGE_NAME .'
                }
            }
        }

        stage('push'){
            steps{
                script{
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'Password', usernameVariable: 'Username')]) {
                    sh 'docker login --username $Username --password $Password'
                    sh 'docker tag $DOCKER_IMAGE_NAME $DOCKER_HUB_REPO/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG'
                    sh 'docker push $DOCKER_HUB_REPO/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG'
                    }
                }
            }
        }
        stage('Remove Local Image') {
            steps {
                // Step 1: Remove the Docker image from the local system
                sh "docker rmi $DOCKER_IMAGE_NAME"
                sh "docker rmi $DOCKER_HUB_REPO/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG"
         	   }
        			    }

        stage('deploy'){
            steps{
                script{
                    withAWS(credentials: 'aws-cli', region: 'us-east-1') {
                    sh 'aws eks update-kubeconfig --region us-east-1 --name my-cluster'
		    sh "sed -i 's|<DOCKER_HUB_REPO_IMAGE>|${DOCKER_HUB_REPO}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}|g' kubernetes/deployments.yaml"
                    sh 'kubectl apply -f kubernetes/'
                    }
                }
            }
        }
    }
    post {
        success {
            script {
                // Step 1: Sleep 15 Sec Till All Pods Be Runnig
                sleep 15
                // Step 2: Get LB IP address
                def serviceName = 'app'
                def url = sh(script: "kubectl get svc ${serviceName} -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'", returnStdout: true).trim()
                echo "Website URL: http://${url}"
            }
        }
        failure {
            echo "Build Failed. Please Check The Build Logs To Fix The Error."
        }

}
}
