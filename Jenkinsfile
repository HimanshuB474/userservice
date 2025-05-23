pipeline {
    agent any

    environment {
        // use forward-slashes even on Windows
        GRADLE_USER_HOME = "${WORKSPACE}/gradle_home"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Setup Permissions & Prepare') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'chmod +x gradlew'
                        sh 'mkdir -p ${GRADLE_USER_HOME}/wrapper/dists'
                    } else {
                        // grant exec, then create nested dirs in one go
                        bat 'icacls gradlew.bat /grant Everyone:F'
                        bat 'mkdir "%GRADLE_USER_HOME%\\wrapper\\dists"'
                    }
                }
            }
        }

        stage('Build & Test') {
            steps {
                script {
                    if (isUnix()) {
                        sh './gradlew clean build test --no-daemon --gradle-user-home=${GRADLE_USER_HOME}'
                    } else {
                        bat 'gradlew.bat clean build test --no-daemon --gradle-user-home=%GRADLE_USER_HOME%'
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                echo '🚀 Deployment placeholder (add your real deploy steps here)'
            }
        }
    }

    post {
        always { cleanWs() }
        failure { echo '❌ Build or Tests failed. Please check the logs.' }
        success { echo '🎉 Build and Tests completed successfully!' }
    }
}
