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
    stage('Remove Unused docker image') {
      steps {
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
    stage('Hello AWS') {
      steps {
        withAWS(credentials: 'aws-key', region: 'us-east-1') {
          echo 'Success'
          sh 'kubectl config use-context arn:aws:cloudformation:us-east-1:724427472536:stack/eksctl-udacity-devops-capstone-b-cluster/f157f2e0-da81-11e9-bad8-127e9735111e'
        }

      }
    }
    stage('Apply K8 File') {
      steps {
        withAWS(credentials: 'aws-key', region: 'us-east-1') {
          echo 'Success'
        }

      }
    }
  }
  environment {
    registry = 'jjjones/udacity-devops-capstone-blue'
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
}
