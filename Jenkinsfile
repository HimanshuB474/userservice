pipeline {
    agent any

    environment {
        JAVA_HOME = tool 'JDK-17'
    }

    stages {
        stage('Set Gradle User Home') {
            steps {
                script {
                    env.GRADLE_USER_HOME = "${env.WORKSPACE}\\gradle_home".replaceAll(/[\\/]+$/, '')
                }
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Setup') {
            steps {
                script {
                    if (isUnix()) {
                        sh '''
                            chmod +x gradlew
                            mkdir -p gradle_home
                            chmod -R 777 gradle_home
                        '''
                    } else {
                        bat '''
                            mkdir gradle_home 2>nul
                            icacls gradle_home /grant Everyone:(OI)(CI)F /T
                            icacls gradlew.bat /grant Everyone:F
                        '''
                    }
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    if (isUnix()) {
                        sh './gradlew clean build --no-daemon --gradle-user-home=${GRADLE_USER_HOME} --info'
                    } else {
                        bat "gradlew.bat clean build --no-daemon --gradle-user-home=\"%GRADLE_USER_HOME:\\=\\\\%\" --info"
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    if (isUnix()) {
                        sh './gradlew test --no-daemon --gradle-user-home=${GRADLE_USER_HOME} --info'
                    } else {
                        bat "gradlew.bat test --no-daemon --gradle-user-home=\"%GRADLE_USER_HOME:\\=\\\\%\" --info"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the build...'
                // Add your deployment steps here
            }
        }
    }

    post {
        success {
            echo '✅ Build and Tests passed successfully!'
        }
        failure {
            echo '❌ Build or Tests failed. Please check the logs.'
        }
        always {
            cleanWs()
        }
    }
}
