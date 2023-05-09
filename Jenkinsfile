pipeline {
  agent {
    docker {
      image 'test:1'
      args '--user root -v /var/run/docker.sock:/var/run/docker.sock' // mount Docker socket to access the host's Docker daemon
    }
  }
  stages {
    stage('Checkout') {
      steps {
        sh 'echo passed'
        git branch: 'maaster', url: 'https://github.com/damaigualca/demo-devops-java.git'
      }
    }
    stage('Build and Test') {
      steps {
        sh 'ls -ltr'
        // build the project and create a JAR file
        sh 'cd demo-devops-java/ && mvn clean package'
      }
    }
    stage('Static Code Analysis') {
      environment {
        SONAR_URL = "http://192.168.100.50:9000"
      }
      steps {
        withCredentials([string(credentialsId: 'sonarqube', variable: 'SONAR_AUTH_TOKEN')]) {
          sh 'cd demo-devops-java && mvn sonar:sonar -Dsonar.login=$SONAR_AUTH_TOKEN -Dsonar.host.url=${SONAR_URL}'
        }
      }
    }
    stage('Build and Push Docker Image') {
      environment {
        DOCKER_IMAGE = "admaigualca/test:${BUILD_NUMBER}"
        // DOCKERFILE_LOCATION = "demo-devops-java/Dockerfile"
        REGISTRY_CREDENTIALS = credentials('docker-cred')
      }
      steps {
        script {
            sh 'cd demo-devops-java && docker build -t ${DOCKER_IMAGE} .'
            def dockerImage = docker.image("${DOCKER_IMAGE}")
            docker.withRegistry('https://index.docker.io/v1/', "docker-cred") {
                dockerImage.push()
            }
        }
      }
    }
    stage('Deploy project to develop') {
        when {
            expression { BRANCH_NAME ==~ /(main)/ }
        }
        steps {
            container('kustomize') {
                echo 'Deploying to develop environment..'
                checkout([$class: 'GitSCM',
                    branches: [[name: '*/main' ]],
                    extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'argocd-develop-apps'], [$class: 'ScmName', name: 'argocd-develop-apps']],
                    userRemoteConfigs: [[
                          url: 'https://github.com/damaigualca/argo-master.git',
                          credentialsId: gitlabCredential
                      ]]
                  ])
                  dir('./devsu/' + argoCDFolderApp + '/settings' ) {
                      sh('kustomize edit set image ' + env.REGISTRY + imageName + ':' + env.GIT_COMMIT)
                      sh('git config --global user.email jenkinsci@ci.com')
                      sh('git config --global user.name Jenkins Pipeline')
                      sh "git commit -am 'Publish new version ${argoCDFolderApp}'"
                      withCredentials([usernamePassword(credentialsId: gitlabCredential, passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                          sh "git push https://${GIT_USERNAME}:${GIT_PASSWORD}@${env.ARGO_APPS_DEVELOP} HEAD:main || echo 'no changes'"
                      }
                  }
              }
          }
      }
  }
}