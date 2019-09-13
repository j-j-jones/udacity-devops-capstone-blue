pipeline {
  
   environment {
    registry = 'jjjones/udacity-devops-capstone-blue'
    registryCredential = 'dockerhub'
    dockerImage = ''
   } 
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
    
    stage('hello AWS') {
            steps {
                withAWS(credentials: 'aws-static', region: 'us-east-1') {
                    sh 'echo "hello KB">hello.txt'
                    //s3Upload acl: 'Private', bucket: 'kb-bucket', file: 'hello.txt'
                    //s3Download bucket: 'kb-bucket', file: 'downloadedHello.txt', path: 'hello.txt'
                    //sh 'cat downloadedHello.txt'
                }
            }
        }
    
    stage('Create EKS Cluster') {
      steps {
        sh ("ls -a")
        //sh ("eksctl version")
        //sh ("eksctl create cluster --name udacity-devops-capstone --version 1.13 --region us-east-1 --nodegroup-name standard-workers --node-type t2.micro --nodes 3 --nodes-min 1 --nodes-max 4 --node-ami auto")
      }
    }
  }
 

}
