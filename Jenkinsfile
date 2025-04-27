pipeline {
    agent any

    environment {
        GRADLE_USER_HOME = "${WORKSPACE}/gradle_home"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Setup Permissions') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'chmod +x gradlew'
                    } else {
                        bat 'icacls gradlew.bat /grant Everyone:F'
                    }
                }
            }
        }

        stage('Build and Test') {
            steps {
                script {
                    if (isUnix()) {
                        sh '''
                            ./gradlew clean build test --no-daemon --gradle-user-home=${GRADLE_USER_HOME}
                        '''
                    } else {
                        bat """
                            gradlew.bat clean build test --no-daemon --gradle-user-home=%GRADLE_USER_HOME%
                        """
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                echo '🚀 Deployment stage (placeholder)'
                // add your deploy commands here
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        failure {
            echo '❌ Build or Tests failed. Please check the logs.'
        }
        success {
            echo '🎉 Build and Tests completed successfully!'
        }
    }
}
