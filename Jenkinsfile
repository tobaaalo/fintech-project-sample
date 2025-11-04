pipeline {
    agent { label 'Jenkins-Agent' }

    tools {
        jdk 'Java17'        // optional, required only if you use a Java-based Sonar scanner
        maven 'Maven3'      // keep if you might need Maven later
        nodejs 'NodeJS'     // required to build and test the Node project
    }

    environment {
        SONARQUBE_SERVER = 'SonarQubeServer'          // name configured in Jenkins → Manage Jenkins → SonarQube servers
        SONAR_PROJECT_KEY = 'fintech-project'         // project key in SonarQube
    }

    stages {
        stage('Cleanup Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout from SCM') {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/tobaaalo/fintech-project-sample.git'
            }
        }

        stage('Build Application') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }

        stage('Test Application') {
            steps {
                sh 'npm test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${SONARQUBE_SERVER}") {
                    sh """
                        sonar-scanner \
                          -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                          -Dsonar.sources=. \
                          -Dsonar.host.url=${SONAR_HOST_URL} \
                          -Dsonar.login=${SONAR_AUTH_TOKEN} \
                          -Dsonar.exclusions=node_modules/**,dist/**
                    """
                    """
                }
            }
        }
    }
}
