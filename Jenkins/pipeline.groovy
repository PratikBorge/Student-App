pipeline {
    agent {
        label 'student'
    }
    tools{
        maven "maven"
    }
    stages {
        stage('Build') {
            steps {
                git branch: 'dev', credentialsId: 'prat', url: 'https://github.com/PratikBorge/Student-App.git'
                dir('./studentapp') {
                    sh'''
                    sudo apt update -y
                    mvn clean package
                    sudo mv ./target/*.war ./target/student.war
                    sudo snap install aws-cli --classic
                    sudo aws s3 cp ./target/student.war s3://artifactforthreeprat/student.war
                    ''' //add role of S3 full access to node instance
                }
           }
        }
        stage('Test') {
            steps{
                echo 'Test is done!'
            }
        }
        stage('Build & Push Backend') {
            steps {
                dir('Docker/Backend') {
                   withCredentials([
                       usernamePassword(
                          credentialsId: 'Docker',
                          usernameVariable: 'DOCKER_USER',
                          passwordVariable: 'DOCKER_PASSWORD'
                      )
                   ]) {
                       sh '''
                          echo "$DOCKER_PASSWORD" | docker login \
                               -u "$DOCKER_USER" \
                               --password-stdin
                           docker build -t "$DOCKER_USER/backend:latest" .
                           docker push "$DOCKER_USER/backend:latest"
                          '''
                       }
                }
            }
        }
         stage('Build & Push Frontend') {
             steps {
                 dir('Docker/Frontend') {
                     withCredentials([
                       usernamePassword(
                          credentialsId: 'Docker',
                          usernameVariable: 'DOCKER_USER',
                          passwordVariable: 'DOCKER_PASSWORD'
                      )
                   ]) {
                      sh '''
                         echo "$DOCKER_PASSWORD" | docker login \
                               -u "$DOCKER_USER" \
                               --password-stdin
                         docker build -t "$DOCKER_USER/frontend:latest" .
                         docker push "$DOCKER_USER/frontend:latest"
                      '''
                }
            }
        }
    }
 }
}       
