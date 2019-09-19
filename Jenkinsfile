pipeline {
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/j-j-jones/udacity-devops-capstone-blue.git'
      }
    }
    stage('Linting HTML') {
      steps {
        echo 'Linting Now...'
        sh 'hostname'
        sh 'tidy -q -e *.html'
      }
    }
    stage('Build Docker Image') {
      steps {
        echo 'Building...'
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }

      }
    }
    stage('Deploy Image') {
      steps {
        echo 'Pushing Image...'
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push("latest")
          }
        }

      }
    }
    stage('Hello AWS') {
      steps {
        withAWS(credentials: 'aws-key', region: 'us-east-1') {
          echo 'Success'
          sh 'kubectl config use-context jenkins-2@udacity-devops-capstone-b.us-east-1.eksctl.io'
          sh 'kubectl apply -f blue-controller.json'
          sh 'kubectl apply -f blue-green-service.json'
        }

      }
    }
    stage('Apply K8 File') {
      steps {
       // withAWS(credentials: 'aws-key', region: 'us-east-1') {
          echo 'Success'
        }

      }
    }
    stage('Remove Unused docker image') {
      steps {
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
  environment {
    registry = 'jjjones/udacity-devops-capstone-blue'
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
}
