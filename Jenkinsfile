pipeline {
    agent any
    
    environment {
        // Set GRADLE_USER_HOME to workspace-specific directory
        GRADLE_USER_HOME = "${WORKSPACE}/.gradle"
        JAVA_HOME = tool 'JDK-17'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Setup') {
            steps {
                script {
                    // Create Gradle directories and set permissions
                    if (isUnix()) {
                        sh '''
                            chmod +x gradlew
                            mkdir -p .gradle
                            chmod -R 777 .gradle
                        '''
                    } else {
                        bat '''
                            mkdir .gradle 2>nul
                            icacls .gradle /grant Everyone:(OI)(CI)F /T
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
                            sh """
                                ./gradlew clean build \
                                    --no-daemon \
                                    --gradle-user-home '${WORKSPACE}/.gradle' \
                                    --info
                            """
                        } else {
                            bat """
                                gradlew.bat clean build ^
                                    --no-daemon ^
                                    --gradle-user-home "%WORKSPACE%\\.gradle" ^
                                    --info
                            """
                        }
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error("Build failed: ${e.message}")
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    try {
                        if (isUnix()) {
                            sh """
                                ./gradlew test \
                                    --no-daemon \
                                    --gradle-user-home '${WORKSPACE}/.gradle' \
                                    --info
                            """
                        } else {
                            bat """
                                gradlew.bat test ^
                                    --no-daemon ^
                                    --gradle-user-home "%WORKSPACE%\\.gradle" ^
                                    --info
                            """
                        }
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error("Tests failed: ${e.message}")
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                // Deploy the project (e.g., copy JAR, deploy to server)
                echo 'Deploying the build...'
                // Add your deployment steps here
            }
        }
    }

    post {
        success {
            echo 'Build and Tests passed successfully!'
        }
        failure {
            echo 'Build or Tests failed. Please check the logs.'
        }
        always {
            // Clean up workspace
            cleanWs()
        }
    }
} 