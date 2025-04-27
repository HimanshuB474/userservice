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

        stage('Set Gradle User Home') {
            steps {
                script {
                    if (isUnix()) {
                        sh '''
                            mkdir -p gradle_home/wrapper/dists
                        '''
                    } else {
                        bat '''
                            mkdir gradle_home 2>nul
                            mkdir gradle_home\\wrapper 2>nul
                            mkdir gradle_home\\wrapper\\dists 2>nul
                        '''
                    }
                }
            }
        }

        stage('Setup') {
            steps {
                script {
                    if (isUnix()) {
                        sh '''
                            chmod +x gradlew
                        '''
                    } else {
                        bat '''
                            icacls gradlew.bat /grant Everyone:F
                        '''
                    }
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    try {
                        if (isUnix()) {
                            sh '''
                                ./gradlew wrapper --gradle-user-home=${GRADLE_USER_HOME}
                                ./gradlew clean build --no-daemon --gradle-user-home=${GRADLE_USER_HOME} --info
                            '''
                        } else {
                            bat '''
                                gradlew.bat wrapper --gradle-user-home=%GRADLE_USER_HOME%
                                gradlew.bat clean build --no-daemon --gradle-user-home=%GRADLE_USER_HOME% --info
                            '''
                        }
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error("❌ Build failed: ${e.message}")
                    }
                }
            }
        }

        stage('Test') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    echo '✅ Running Tests...'
                    if (isUnix()) {
                        sh '''
                            ./gradlew test --no-daemon --gradle-user-home=${GRADLE_USER_HOME}
                        '''
                    } else {
                        bat '''
                            gradlew.bat test --no-daemon --gradle-user-home=%GRADLE_USER_HOME%
                        '''
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
                // Add deployment steps here
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
