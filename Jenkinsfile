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
          sh 'kubectl apply -f ./blue-controller.json'
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
        //sh 'ls *.yaml'
        withAWS(credentials: 'aws-static', region: 'us-east-1') {
          sh 'kubectl config use-context arn:aws:eks:us-east-1:08198f90fe8bc57f0:cluster/udacity-devops-capstone'
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
