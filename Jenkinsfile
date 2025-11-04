pipeline {
    agent { label 'Jenkins-Agent' }

    tools {
        jdk 'Java17'   // optional if you have Java-based SonarQube scanner
        maven 'Maven3' // not used but can stay if other parts need it
    }

    stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }

        stage("Checkout from SCM") {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/tobaaalo/fintech-project-sample.git'
            }
        }

        stage("Build Application") {
            steps {
                sh "npm install"
                sh "npm run build"
            }
        }

        stage("Test Application") {
            steps {
                sh "npm test"
            }
        }

        stage("SonarQube Analysis") {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token') {
                        sh """
                            sonar-scanner \
                              -Dsonar.projectKey=fintech-project \
                              -Dsonar.sources=. \
                              -Dsonar.host.url=${env.SONAR_HOST_URL} \
                              -Dsonar.login=${SONAR_AUTH_TOKEN} \
                              -Dsonar.exclusions=node_modules/**,dist/**
                        """
                    }
                }
            }
        }
    }
}
