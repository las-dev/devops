pipeline {
    agent any
    environment {
        registry = "lasregistry/devops"
            registryCredential = 'DockerHubCreds'


        }
    
    stages {
        

        stage('Clean') {
            steps {

                       sh  'mvn clean install -DskipTests'

            }
            }


   stage('Compile') {
            steps {

                       sh  'mvn compile'
            }
            }

    stage('Test') {
            steps {
                         sh  'mvn test'
                  }
            }
  stage('SonarQube analysis') {
            steps {
                        sh 'mvn  sonar:sonar -Dsonar.login=admin -Dsonar.password=admin123 -Dsonar.projectKey=DevOps'
                  }
            }
stage('Build') {
            steps {
                        sh 'mvn package -DskipTests'
                  }
            }


stage('Deploy') {
            steps {
                        sh 'mvn deploy -DskipTests'
                  }
            }


 stage('build docker image') {
                steps {
                    script {
                        dockerImage = docker.build registry + ":$BUILD_NUMBER"
                    }
                }
            }

stage('push docker image') {
                            steps {
                                script {
                                    docker.withRegistry( '', 'DockerHubCreds' ) {
                                        dockerImage.push('latest')
                                    }
                                }
                            }
                        }

stage('Cleaning up') {
            steps {
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }

stage('start Application ') {
                            steps {
                               sh 'docker-compose up -d '
                            }
                        }

        }

    }
